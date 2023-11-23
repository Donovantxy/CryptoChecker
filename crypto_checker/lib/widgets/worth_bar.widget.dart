import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WorthBarWidget extends StatelessWidget {

  const WorthBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TokenAssetsBloc, TokenAssetsBaseState>(builder: (ctx, state) {
      return Row(
        children: <Widget>[
          Text(_getWorth(state.tokens)),
        ],
      );
    });
  }

  String _getWorth(List<TokenAsset> tokens) {
    final worth = tokens.map((token) => token.price * token.bagSize).reduce((value, element) => value+element);
    return NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 2).format(worth);
  }

}
