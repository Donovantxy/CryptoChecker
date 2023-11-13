

import 'dart:io';

import 'package:crypto_checker/services/dexscreener/dexscreener.models.dart';

class DexScreenerService {

  static const quoteToken = 'USDT';

  DexScreenerService();

  Future<TokenPair> getTokenPair(String tokenSymbol) {
    return http().get(host, port, path)
  }

}