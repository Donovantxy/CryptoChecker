
import 'package:crypto_checker/views/settings_view/settings.view.dart';
import 'package:crypto_checker/views/token_list/token_list.view.dart';
import 'package:crypto_checker/views/wallet/wallet.view.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  static String walletView = '/';
  static String tokenListView = '/list';
  static String settingsView = '/settings';
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoutes.walletView: (context) => const WalletView(),
      AppRoutes.tokenListView: (context) => const TokenListView(),
      AppRoutes.settingsView: (context) => const SettingView(),
    };
  }
}