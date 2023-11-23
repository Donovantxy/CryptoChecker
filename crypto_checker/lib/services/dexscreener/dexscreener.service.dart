import 'dart:convert';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/models/token_pair/token_pair.dart';
import 'package:http/http.dart' as http;

class DexScreenerService {
  final String quoteToken = 'USDT';

  const DexScreenerService();

  Future<List<TokenPair>> searchTokenPair(String tokenSymbol, [String? tokenAdditionalSymbol]) async {
    final response = await http.get(Uri.parse('https://api.dexscreener.com/latest/dex/search/?q=$tokenSymbol/$quoteToken'));
    if (response.statusCode == 200) {
      var pairs = jsonDecode(response.body)['pairs'] as List;
      return pairs
          .map((pair) => TokenPair.fromJson(pair))
          .where((pair) => pair.baseToken?.symbol == tokenSymbol || pair.baseToken?.symbol == tokenAdditionalSymbol)
          .toList();
    }
    throw Exception('Failed to fetch data -> getTokenPair');
  }

  Future<TokenPair> getTokenPair(TokenAsset tokenAsset) async {
    final response = await http.get(Uri.parse('https://api.dexscreener.com/latest/dex/pairs/${tokenAsset.chainId}/${tokenAsset.pairAddress}'));
    if (response.statusCode == 200) {
      var pairs = jsonDecode(response.body)['pairs'] as List;
      if (pairs.isNotEmpty) {
        return TokenPair.fromJson(pairs[0]);
      }
      throw Exception('Failed to fetch data -> getTokenPair');
    }
    throw Exception('Failed to fetch data -> getTokenPair');
  }
}
