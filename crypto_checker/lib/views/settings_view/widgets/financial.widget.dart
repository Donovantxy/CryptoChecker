import 'package:crypto_checker/main.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/models/currencies.model.dart';
import 'package:crypto_checker/models/financial_record.dart';
import 'package:crypto_checker/services/settings.service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class FinancialWidget extends StatefulWidget {
  const FinancialWidget({super.key});

  @override
  State<FinancialWidget> createState() => _FinancialWidgetState();
}

class _FinancialWidgetState extends State<FinancialWidget> {
  String toReinvestInUSD = '0.00';
  double netGain = 0.00;
  double worth = 0.00;
  final settingsService = SettingsService();
  final Map<String, String> _availableCurrencies = {
    r"$": 'USD',
    '£': 'GBP',
    '€': 'EUR',
  };
  String _FINANCIAL_RECORD_KEY = 'financial_01';
  late FinancialRecord _financialRecord;
  late Box<FinancialRecord> _boxFinancial;
  late double _conversionRate;

  @override
  void initState() {
    _boxFinancial = Hive.box<FinancialRecord>(HIVE_FINANCIAL_BOX_NAME);
    final boxTokenAsset = Hive.box<TokenAsset>(HIVE_TOKENASSET_BOX_NAME);

    if (_boxFinancial.get(_FINANCIAL_RECORD_KEY) == null) {
      _financialRecord = FinancialRecord(currency: r'$', toReinvestPerc: 0, taxPerc: 0);
      _boxFinancial.put(_FINANCIAL_RECORD_KEY, _financialRecord);
    } else {
      _financialRecord = _boxFinancial.get(_FINANCIAL_RECORD_KEY)!;
    }

    setConversionRate(_financialRecord.currency);

    boxTokenAsset.keys.forEach((key) {
      TokenAsset? token = boxTokenAsset.get(key)!;
      worth += token.bagSize * token.price;
    });
    netGain = getNetGain(_conversionRate);
    toReinvestInUSD = double.parse((worth * _financialRecord.toReinvestPerc / 100).toString()).toStringAsFixed(2);

    super.initState();
  }

  setConversionRate(currency) async {
    _conversionRate = 1;
    if (_financialRecord.currency != _availableCurrencies[r'$']) {
      CurrencyConversion conversion = await settingsService.getConversionFromUSD(_availableCurrencies[_financialRecord.currency]!);
      _conversionRate = conversion.rates![_availableCurrencies[_financialRecord.currency]]!;
    }
  }

  double getNetGain(double conversionRate) =>
      worth * ((100 - _financialRecord.toReinvestPerc) / 100) * ((100 - _financialRecord.taxPerc) / 100) * conversionRate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  'Taxation ${_financialRecord.taxPerc}%',
                  style: const TextStyle(fontSize: 20),
                ),
                Slider(
                  value: _financialRecord.taxPerc.toDouble(),
                  min: 0,
                  max: 100,
                  inactiveColor: Colors.blueGrey.shade100,
                  onChanged: (value) {
                    setState(() {
                      _financialRecord.taxPerc = value.round();
                      netGain = getNetGain(_conversionRate);
                    });
                  },
                  onChangeEnd: (value) async {
                    _financialRecord.taxPerc = value.round();
                    await _financialRecord.save();
                  },
                ),
                Text(
                  'To reinvest ${_financialRecord.toReinvestPerc}% - \$$toReinvestInUSD',
                  style: const TextStyle(fontSize: 20),
                ),
                Slider(
                  value: _financialRecord.toReinvestPerc.toDouble(),
                  min: 0,
                  max: 100,
                  inactiveColor: Colors.blueGrey.shade100,
                  onChanged: (value) {
                    setState(() {
                      _financialRecord.toReinvestPerc = value.round();
                      toReinvestInUSD = double.parse((worth * _financialRecord.toReinvestPerc / 100).toString()).toStringAsFixed(2);
                      netGain = getNetGain(_conversionRate);
                    });
                  },
                  onChangeEnd: (value) async {
                    _financialRecord.toReinvestPerc = value.round();
                    await _financialRecord.save();
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Net gain -',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Text(
                            NumberFormat.decimalPatternDigits(locale: 'en_US', decimalDigits: 2).format(netGain),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton<String>(
                            elevation: 1,
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            value: _financialRecord.currency,
                            items: _availableCurrencies.entries.toList().map((MapEntry<String, String> entry) {
                              return DropdownMenuItem<String>(
                                value: entry.key,
                                child: Text(entry.key),
                              );
                            }).toList(),
                            onChanged: (newValue) async {
                              double conversionRate = 1;
                              if (_financialRecord.currency != newValue) {
                                final conversion = await settingsService.getConversionFromUSD(_availableCurrencies[newValue]!);
                                if (conversion.rates != null) {
                                  _financialRecord.currency = newValue!;
                                  conversionRate = conversion.rates![_availableCurrencies[_financialRecord.currency]]!;
                                  await _financialRecord.save();
                                  setState(() {
                                    netGain = getNetGain(conversionRate) * conversionRate;
                                  });
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
