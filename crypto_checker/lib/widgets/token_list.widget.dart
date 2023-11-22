import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/widgets/token_list_item.widget.dart';
import 'package:flutter/material.dart';

class TokenListWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  TokenListWidget({super.key, this.padding = const EdgeInsets.fromLTRB(10, 5, 10, 10)});

  final tokenAssetList = TokenAssetList.get();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: tokenAssetList.length,
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
                    }))
          ],
        )));
  }
}
