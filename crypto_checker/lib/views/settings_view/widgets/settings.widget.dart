import 'package:crypto_checker/main.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/services/settings.service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  int taxationPercentage = 0;
  int toReinvestInPerc = 0;
  String toReinvestInUSD = '0.00';
  double netGain = 0.00;
  double worth = 10000.00;
  String selectedCurrency = r'$';
  final Map<String, String> _availableCurrencies = {
    r"$": 'USD',
    '£': 'GBP',
    '€': 'EUR',
  };
  double currentCapital = 9100.45;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<TokenAsset>(HIVE_TOKENASSET_BOX_NAME);
    final settingsService = SettingsService();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  'Taxation $taxationPercentage%',
                  style: const TextStyle(fontSize: 20),
                ),
                Slider(
                  value: taxationPercentage.toDouble(),
                  min: 0,
                  max: 100,
                  inactiveColor: Colors.blueGrey.shade100,
                  onChanged: (value) {
                    setState(() {
                      taxationPercentage = value.round();
                    });
                  },
                ),
                Text(
                  'To reinvest $toReinvestInPerc% - \$$toReinvestInUSD',
                  style: const TextStyle(fontSize: 20),
                ),
                Slider(
                  value: toReinvestInPerc.toDouble(),
                  min: 0,
                  max: 100,
                  inactiveColor: Colors.blueGrey.shade100,
                  onChanged: (value) {
                    setState(() {
                      toReinvestInPerc = value.round();
                      toReinvestInUSD = double.parse((worth * toReinvestInPerc / 100).toString()).toStringAsFixed(2);
                    });
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
                            value: selectedCurrency,
                            items: _availableCurrencies.entries.toList().map((MapEntry<String, String> entry) {
                              return DropdownMenuItem<String>(
                                value: entry.key,
                                child: Text(entry.key),
                              );
                            }).toList(),
                            onChanged: (newValue) async {
                              double conversionRate = 1;
                              if (selectedCurrency != newValue) {
                                final conversion = await settingsService.getConversionFromUSD(_availableCurrencies[newValue]!);
                                if (conversion.rates != null) {
                                  selectedCurrency = newValue!;
                                  conversionRate = conversion.rates![_availableCurrencies[selectedCurrency]]!;
                                  setState(() {
                                    print('$worth - $conversionRate');
                                    netGain = worth * conversionRate;
                                    print('$netGain');
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
