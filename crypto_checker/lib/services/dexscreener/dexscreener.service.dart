import 'dart:convert';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/models/token_pair/token_pair.dart';
import 'package:http/http.dart' as http;

// https://docs.dexscreener.com/api/reference
class DexScreenerService {
  final String quoteToken = 'USDT';
  final String COIN_MARKET_CAP_API_KEY = 'c40d9fb0-bb51-4ec9-80dd-eec70b3a9a71';

  const DexScreenerService();

  // Future<List<TokenPair>> searchTokenPair(String tokenSymbol, [String? tokenAdditionalSymbol]) async {
  //   final response = await http.get(Uri.parse('https://api.dexscreener.com/latest/dex/search/?q=$tokenSymbol/$quoteToken'));
  //   if (response.statusCode == 200) {
  //     var pairs = jsonDecode(response.body)['pairs'] as List;
  //     return pairs
  //         .map((pair) => TokenPair.fromJson(pair))
  //         .where((pair) => pair.baseToken?.symbol == tokenSymbol || pair.baseToken?.symbol == tokenAdditionalSymbol)
  //         .toList();
  //   }
  //   throw Exception('Failed to fetch data -> getTokenPair');
  // }

  // Future<TokenPair> getTokenPair(TokenAsset tokenAsset) async {
  //   final response = await http.get(Uri.parse('https://api.dexscreener.com/latest/dex/pairs/${tokenAsset.chainId}/${tokenAsset.pairAddress}'));
  //   if (response.statusCode == 200) {
  //     print(tokenAsset.symbol);
  //     var pairs = jsonDecode(response.body)['pairs'] as List;
  //     print(pairs);
  //     print('\n');
  //     if (pairs.isNotEmpty) {
  //       return TokenPair.fromJson(pairs[0]);
  //     }
  //     throw Exception('Failed to fetch data -> getTokenPair');
  //   }
  //   throw Exception('Failed to fetch data -> getTokenPair');
  // }

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
          map[key] = QuotesLatest(id: value['id'], name: value['name'], symbol: value['symbol'], usd: value['quote']['USD']['price']);
        }
      });
      return map;
    }
    throw Exception('Failed to fetch data -> getTokenQuotes');
  }
}
