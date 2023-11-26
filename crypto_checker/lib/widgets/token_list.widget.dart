import 'dart:async';

import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/widgets/token_list_item.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TokenListWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  const TokenListWidget({super.key, this.padding = const EdgeInsets.all(10)});

  @override
  Widget build(BuildContext context) {
    _startPollingData(context);
    return Padding(
      padding: padding,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Expanded(child: _loadTokenAssets())],
        ),
      ),
    );
  }

  BlocBuilder _loadTokenAssets() {
    return BlocBuilder<TokenAssetsBloc, TokenAssetsBaseState>(builder: (ctx, state) {
      List<TokenAsset> visibleTokens = state.tokens.where((token) => token.isVisible!).toList();
      return ListView.builder(
          itemCount: visibleTokens.length,
          itemBuilder: (ctx, index) {
            return Card(
                margin: const EdgeInsets.only(bottom: 15, left: 6, right: 6),
                elevation: 2.0,
                clipBehavior: Clip.antiAlias,
                child: Slidable(
                  key: ValueKey(visibleTokens[index].pairAddress),
                  startActionPane: _startActionPane(visibleTokens[index].symbol),
                  child: InkWell(
                    splashColor: Colors.blueGrey[200],
                    child: TokenPairItem(
                      key: ValueKey(visibleTokens[index].pairAddress),
                      tokenAsset: visibleTokens[index],
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

  ActionPane _startActionPane(String symbol) {
    return ActionPane(
      extentRatio: 0.15,
      motion: const BehindMotion(),
      children: [
        SlidableAction(
          onPressed: (BuildContext context) {
            context.read<TokenAssetsBloc>().add(HideTokenEvent(symbol));
          },
          backgroundColor: Colors.red.shade900,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          // label: 'Hide',
        ),
      ],
    );
  }
}
