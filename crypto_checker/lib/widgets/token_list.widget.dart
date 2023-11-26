import 'dart:async';

import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/widgets/token_list_item.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TokenListWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  const  TokenListWidget({super.key, this.padding = const EdgeInsets.all(10)});

  @override
  Widget build(BuildContext context) {
    _startPollingData(context);
    return Padding(
        padding: padding,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Expanded(child: _loadTokenAssets())],
        )));
  }

  BlocBuilder _loadTokenAssets() {
    return BlocBuilder<TokenAssetsBloc, TokenAssetsBaseState>(builder: (ctx, state) {

      return ListView.builder(
          itemCount: state.tokens.length,
          itemBuilder: (ctx, index) {
            return Card(
                margin: const EdgeInsets.only(bottom: 15, left: 6, right: 6),
                elevation: 2.0,
                clipBehavior: Clip.antiAlias,
                child: Slidable(
                  key: ValueKey(state.tokens[index].pairAddress),
                  child: InkWell(
                    splashColor: Colors.blueGrey[200],
                    child: TokenPairItem(
                      key: ValueKey(state.tokens[index].pairAddress),
                      tokenAsset: state.tokens[index],
                    ),
                  ),
                ));
          });
    });
  }

  void _startPollingData(BuildContext ctx) {
    BlocProvider.of<TokenAssetsBloc>(ctx).add(FetchTokenDataEvent());
    Timer.periodic(const Duration(minutes: 1), (_) {
      BlocProvider.of<TokenAssetsBloc>(ctx).add(FetchTokenDataEvent());
    });
  }

}
