import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/routes.dart';
import 'package:crypto_checker/views/wallet/widgets/wallet_token_list.widget.dart';
import 'package:crypto_checker/widgets/shared/cc_scaffold.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TokenAssetsBloc, TokenAssetsBaseState>(
        listener: (context, state) {
        if (state is TokenFetchErrorState) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.settingsView);
        }
      },
      child: const CcScaffoldWidget(appBarTitle: 'Wallet', body: WalletTokenListWidget())
    );
  }
}
