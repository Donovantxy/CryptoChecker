import 'dart:convert';
import 'dart:io';

import 'package:crypto_checker/services/dexscreener/dexscreener.models.dart';
import 'package:http/http.dart' as http;

class DexScreenerService {
  static const quoteToken = 'USDT';

  DexScreenerService();

  Future<List<TokenPair>> getTokenPair(String tokenSymbol) async {
    final response = await http.get(Uri.parse('https://api.dexscreener.com/latest/dex/search/?q=$tokenSymbol/$quoteToken'));
    if ( response.statusCode == 200 ) {
      var pairs = jsonDecode(response.body)['pairs'] as List;
      return pairs.map((pair) => TokenPair.fromJson(pair)).toList();
    }
    throw Exception('Failer to fetch data');

  }
}
