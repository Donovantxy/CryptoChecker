import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/models/token_pair/token_pair.dart';
import 'package:crypto_checker/widgets/bag_setting_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TokenPairItem extends StatefulWidget {
  final TokenAsset tokenAsset;

  const TokenPairItem({super.key, required this.tokenAsset});

  @override
  State<TokenPairItem> createState() => _TokenPairItemState();
}

class _TokenPairItemState extends State<TokenPairItem> with AutomaticKeepAliveClientMixin<TokenPairItem> {
  late TokenPair tokenPair;
  bool isLoading = true;
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        titleAlignment: ListTileTitleAlignment.center,
        leading: _getLeadingIcon(),
        title: Text(
          widget.tokenAsset.symbol,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Text(
              'price: ${widget.tokenAsset.price == 0 ? '---' : '\$${widget.tokenAsset.price}'}\nbag: ${widget.tokenAsset.bagSize}\ntotal: ${_getAsset(widget.tokenAsset)}',
              style: const TextStyle(height: 1.4)),
        ),
        onTap: () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return _showBagSettingDialog(context, widget.tokenAsset.symbol);
              });
        });
  }

  Widget _getLeadingIcon() {
    Widget img;
    if (widget.tokenAsset.icon.endsWith('.svg')) {
      img = SvgPicture.asset(widget.tokenAsset.icon);
    } else {
      img = Image.asset(widget.tokenAsset.icon);
    }
    return SizedBox(width: 64.0, height: 64.0, child: img);
  }

  String _getAsset(TokenAsset token) {
    double capital = (token.bagSize * token.price);
    return NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 2).format(capital);
  }

  BagSettingDialogWidget _showBagSettingDialog(BuildContext ctx, String symbol) {
    return BagSettingDialogWidget(
      tokenSymbol: symbol,
      onBagSettingSubmit: (int amount) async {
        ctx.read<TokenAssetsBloc>().add(UpdateTokenBagSizeEvent(symbol, amount));
      },
    );
  }

}
