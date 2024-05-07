import 'dart:math';

import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/models/token_pair/token_pair.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:crypto_checker/views/wallet/widgets/bag_setting_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class WalletTokenListItem extends StatefulWidget {
  final TokenAsset tokenAsset;

  const WalletTokenListItem({super.key, required this.tokenAsset});

  @override
  State<WalletTokenListItem> createState() => _WalletTokenListItemState();
}

class _WalletTokenListItemState extends State<WalletTokenListItem>
    with AutomaticKeepAliveClientMixin<WalletTokenListItem> {
  late TokenPair tokenPair;
  bool isLoading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final FocusNode bagAmountFocusNode = FocusNode();

    return ListTile(
      tileColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      titleAlignment: ListTileTitleAlignment.center,
      leading: _getLeadingIcon(),
      title: Text(
        widget.tokenAsset.symbol,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                  'price: ${widget.tokenAsset.price == 0 ? '---' : CoinMarketCapService.floatDigits(widget.tokenAsset.price)}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                  'bag: ${NumberFormat.decimalPatternDigits(locale: 'en_US', decimalDigits: 2).format(widget.tokenAsset.bagSize)}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                'total: ${_getAsset(widget.tokenAsset)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [..._getTrailingPercs()],
        ),
      ),
      onTap: () {
        showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return _showBagSettingDialog(
                  context, widget.tokenAsset, bagAmountFocusNode);
            });
        bagAmountFocusNode.requestFocus();
      },
    );
  }

  // List<Widget> _getTrailing() {
  //   final int sign = widget.tokenAsset.percentage > 0 ? 1 : -1;
  //   return [
  //     Transform.rotate(
  //       angle: sign * (-pi / 2),
  //       child: Icon(
  //         size: 32,
  //         Icons.double_arrow,
  //         color: sign > 0 ? Colors.green : Colors.red[800],
  //       ),
  //     ),
  //     const SizedBox(width: 6),
  //     SizedBox(
  //       width: 65,
  //       child: Text(
  //         textAlign: TextAlign.start,
  //         '${widget.tokenAsset.percentage.toStringAsFixed((2))}%',
  //         style: const TextStyle(fontSize: 14),
  //       ),
  //     ),
  //   ];
  // }
  
  List<Widget> _getTrailingPercs() {
    final String signD = widget.tokenAsset.percentageD > 0 ? '+' : '';
    final String signW = widget.tokenAsset.percentageW > 0 ? '+' : '';
    final String signM = widget.tokenAsset.percentageM > 0 ? '+' : '';
    const double width = 100;
    const double fontSize = 12.5;
    return [
      SizedBox(
        width: width,
        child: Text(
          textAlign: TextAlign.start,
          'D $signD${widget.tokenAsset.percentageD.toStringAsFixed((2))}%',
          style: TextStyle(fontSize: fontSize, color: signD == '+' ? Colors.green : Colors.red[800]),
        ),
      ),
      SizedBox(
        width: width,
        child: Text(
          textAlign: TextAlign.start,
          'W $signW${widget.tokenAsset.percentageW.toStringAsFixed((2))}%',
          style: TextStyle(fontSize: fontSize, color: signW == '+' ? Colors.green : Colors.red[800] ),
        ),
      ),
      SizedBox(
        width: width,
        child: Text(
          textAlign: TextAlign.start,
          'M $signM${widget.tokenAsset.percentageM.toStringAsFixed((2))}%',
          style: TextStyle(fontSize: fontSize, color: signM == '+' ? Colors.green : Colors.red[800]),
        ),
      ),
    ];
  }

  Widget _getLeadingIcon() {
    Widget img;
    if (widget.tokenAsset.icon!.endsWith('.svg')) {
      img = SvgPicture.asset(widget.tokenAsset.icon!);
    } else {
      img = Image.asset(widget.tokenAsset.icon!);
    }
    return SizedBox(width: 64.0, height: 64.0, child: img);
  }

  String _getAsset(TokenAsset token) {
    double capital = (token.bagSize * token.price);
    return CoinMarketCapService.floatDigits(capital);
  }

  BagSettingDialogWidget _showBagSettingDialog(
      BuildContext ctx, TokenAsset token, final FocusNode bagAmountFocusNode) {
    return BagSettingDialogWidget(
      tokenSymbol: token.symbol,
      amount: token.bagSize,
      focusNode: bagAmountFocusNode,
      onBagSettingSubmit: (double amount) async {
        ctx
            .read<TokenAssetsBloc>()
            .add(UpdateTokenBagSizeEvent(token.symbol, amount));
      },
    );
  }

  String getDetails() => '''
price: ${widget.tokenAsset.price == 0 ? '---' : '\$${widget.tokenAsset.price}'}
bag: ${NumberFormat.decimalPatternDigits(locale: 'en_US', decimalDigits: 2).format(widget.tokenAsset.bagSize)}
total: ${_getAsset(widget.tokenAsset)}
''';
}
