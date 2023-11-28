import 'package:crypto_checker/views/wallet/widgets/wallet_token_list.widget.dart';
import 'package:crypto_checker/widgets/shared/cc_app_bar.widget.dart';
import 'package:crypto_checker/widgets/shared/cc_scaffold.widget.dart';
import 'package:flutter/material.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return CcScaffoldWidget(
      appBar: CcAppBar.getAppBar(context),
      body: const Column(
        children: [
          Expanded(
            child: WalletTokenListWidget(),
          ),
        ],
      ),
    );
  }
}
