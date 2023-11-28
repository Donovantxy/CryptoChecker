
import 'package:crypto_checker/views/token_list.view.dart';
import 'package:crypto_checker/views/wallet.view.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static String walletView = '/';
  static String tokenListView = '/list';
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoutes.walletView: (context) => const WalletView(),
      AppRoutes.tokenListView: (context) => const TokenListView(),
    };
  }
}