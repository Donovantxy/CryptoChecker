import 'dart:convert';
import 'dart:io';

import 'package:crypto_checker/models/token_pair/token_pair.dart';
import 'package:http/http.dart' as http;

class DexScreenerService {
  static const quoteToken = 'USDT';

  DexScreenerService();

  Future<List<TokenPair>> getTokenPair(String tokenSymbol, [String? tokenAdditionalSymbol]) async {
    final response = await http.get(Uri.parse(
        'https://api.dexscreener.com/latest/dex/search/?q=$tokenSymbol/$quoteToken'));
    if (response.statusCode == 200) {
      var pairs = jsonDecode(response.body)['pairs'] as List;
      return pairs.map((pair) => TokenPair.fromJson(pair)).where((pair) => pair.baseToken?.symbol == tokenSymbol || pair.baseToken?.symbol == tokenAdditionalSymbol ).toList();
    }
    throw Exception('Failed to fetch data');
  }
}
