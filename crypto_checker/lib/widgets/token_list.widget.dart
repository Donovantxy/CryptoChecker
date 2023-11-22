import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/widgets/token_list_item.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenListWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  TokenListWidget({super.key, this.padding = const EdgeInsets.all(10)});

  final tokenAssetList = TokenAssetList.get();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Expanded(child: _loadTokenAssets())],
        )));
  }

  BlocBuilder _loadTokenAssets() {
    return BlocBuilder<TokenAssetsBloc, TokenAssetsState>(builder: (ctx, state) {
      if (state is TokenAssetsInitialSt) {
        return ListView.builder(
            itemCount: state.initialTokens.length,
            itemBuilder: (ctx, index) {
              return Card(
                  margin: const EdgeInsets.only(bottom: 15, left: 6, right: 6),
                  elevation: 2.0,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blueGrey[200],
                    child: TokenPairItem(
                      key: ValueKey(tokenAssetList[index].pairAddress),
                      tokenAsset: tokenAssetList[index],
                    ),
                  ));
            });
      }
      return Container();
    });
  }
}
