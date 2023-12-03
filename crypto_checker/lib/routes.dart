
import 'package:crypto_checker/views/settings_view/financial.view.dart';
import 'package:crypto_checker/views/token_list/token_list.view.dart';
import 'package:crypto_checker/views/wallet/wallet.view.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static String walletView = '/';
  static String tokenListView = '/list';
  static String financialView = '/financial';
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoutes.walletView: (context) => const WalletView(),
      AppRoutes.tokenListView: (context) => const TokenListView(),
      AppRoutes.financialView: (context) => const FinancialView(),
    };
  }
}