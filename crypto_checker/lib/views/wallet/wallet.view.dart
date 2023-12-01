import 'package:crypto_checker/views/wallet/widgets/wallet_token_list.widget.dart';
import 'package:crypto_checker/widgets/shared/cc_scaffold.widget.dart';
import 'package:flutter/material.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CcScaffoldWidget(appBarTitle: 'Wallet', body: WalletTokenListWidget());
  }
}
