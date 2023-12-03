import 'dart:convert';

import 'package:crypto_checker/models/currencies.model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SettingsService {
  Future<CurrencyConversion> getConversionFromUSD(String toCurrency) async {
    try {
      if (toCurrency != 'USD') {
        final response = await http.get(Uri.parse('https://api.frankfurter.app/latest?amount=1&from=USD&to=$toCurrency'));
        return CurrencyConversion.fromJson(jsonDecode(response.body));
      }
      return CurrencyConversion(rates: { 'USD': 1.00 });
    } catch (err) {
      return CurrencyConversion(date: DateFormat('dd/MM/yyyy').format(DateTime.now()), rates: { 'USD': 1.00 });
    }
  }
}
