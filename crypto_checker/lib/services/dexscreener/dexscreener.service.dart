import 'dart:convert';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/models/token_pair/token_pair.dart';
import 'package:http/http.dart' as http;

class MarketCoinCapService {
  final String quoteToken = 'USDT';
  final String COIN_MARKET_CAP_API_KEY = '***';
  

  const MarketCoinCapService();

  Future<Map<String, QuotesLatest>?> getTokenQuotes(List<int> ids) async {
    final response = await http.get(
      Uri.parse('https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?id=${ids.join(',')}'),
      headers: {
        'X-CMC_PRO_API_KEY': COIN_MARKET_CAP_API_KEY,
        "Accept": "application/json",
      },
    );
    
    if (response.statusCode == 200) {
      final Map<String, QuotesLatest> map = new Map();
      jsonDecode(response.body)['data'].forEach((String key, value) {
        if ( key != null) {
          map[key] = QuotesLatest(id: value['id'], name: value['name'], symbol: value['symbol'], usd: value['quote']['USD']['price'], percDay: value['quote']['USD']['percent_change_24h']);
        }
      });
      return map;
    }
    throw Exception('Failed to fetch data -> getTokenQuotes');
  }
}
