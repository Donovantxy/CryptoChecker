import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CcAppBar {
  
  static AppBar getAppBar(BuildContext context, String title) {
    return AppBar(
      title: Text(title),
      actions: [
        BlocBuilder<TokenAssetsBloc, TokenAssetsBaseState>(builder: (ctx, state) {
          final worth = state.tokens.map((token) => token.price * token.bagSize).reduce((value, element) => value + element);
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 2).format(worth)),
            ),
          );
        }),
      ],
    );
  }
}
