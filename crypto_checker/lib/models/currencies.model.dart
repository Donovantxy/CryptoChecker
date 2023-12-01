import 'dart:convert';

class CurrencyConversion {
  late double amount;
  late String base;
  String? date;
  Map<String, double>? rates;

  CurrencyConversion({this.amount = 1, this.base = 'USD', this.date, this.rates});

  factory CurrencyConversion.fromJson(Map<String, dynamic> json) {
    Map<String, double>? parsedRates;
    if (json['rates'] != null) {
      parsedRates = (json['rates'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value.toDouble()));
    }
    return CurrencyConversion(
      amount: json['amount'] as double,
      base: json['base'] as String,
      date: json['date'] as String?,
      rates: parsedRates,
    );
  }

  @override
  String toString() {
    return '$base - $amount - $rates - $date';
  }
}
