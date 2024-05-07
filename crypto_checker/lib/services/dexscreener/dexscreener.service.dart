import 'dart:convert';
import 'package:crypto_checker/main.dart';
import 'package:crypto_checker/models/settings.dart';
import 'package:crypto_checker/models/token_pair/token_pair.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class CoinMarketCapService {
  final String quoteToken = 'USDT';
  String _COIN_MARKET_CAP_API_KEY = '';

  CoinMarketCapService() {
    _COIN_MARKET_CAP_API_KEY = Hive.box<Settings>(HIVE_SETTINGS).get(HIVE_SETTINGS)?.coinMarketCapApiKey ?? Settings().coinMarketCapApiKey;
  }

  setKey(String key, ) {
    _COIN_MARKET_CAP_API_KEY = key;
  }

  Future<Map<String, QuotesLatest>?> getTokenQuotes(List<int> ids) async {
    final response = await http.get(
      Uri.parse('https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?id=${ids.join(',')}'),
      headers: {
        'X-CMC_PRO_API_KEY': _COIN_MARKET_CAP_API_KEY,
        "Accept": "application/json",
      },
    );
    
    if (response.statusCode == 200) {
      final Map<String, QuotesLatest> map = {};
      jsonDecode(response.body)['data'].forEach((String key, value) {
        if ( key != null) {
          map[key] = QuotesLatest(
            id: value['id'],
            name: value['name'],
            symbol: value['symbol'],
            usd: value['quote']['USD']['price'],
            percDay: value['quote']['USD']['percent_change_24h'],
            percWeek: value['quote']['USD']['percent_change_7d'],
            percMonth: value['quote']['USD']['percent_change_30d']
          );
        }
      });
      return map;
    }
    throw Exception('Failed to fetch data -> getTokenQuotes');
  }
}
