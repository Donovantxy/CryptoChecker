import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/widgets/bag_setting_dialog.widget.dart';
import 'package:crypto_checker/widgets/token_list_item.widget.dart';
import 'package:flutter/material.dart';

class TokenListWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  TokenListWidget({super.key, this.padding = const EdgeInsets.all(20)});

  final assetTokenList = AssetTokenList.get();

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
                    itemCount: assetTokenList.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                              splashColor: Colors.blueGrey[200],
                              onTap: () {
                                showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return _showBagSettingDialog(context, assetTokenList[index].symbol);
                                    });
                              },
                              child: TokenPairItem(
                                key: ValueKey(assetTokenList[index].pairAddress),
                                assetToken: assetTokenList[index],
                              )));
                    }))
          ],
        )));
  }

  BagSettingDialog _showBagSettingDialog(BuildContext context, String symbol) {
    return BagSettingDialog(
      tokenSymbol: symbol,
      onBagSettingSubmit: (double amount) {
        print(amount);
      },
    );
  }
}
