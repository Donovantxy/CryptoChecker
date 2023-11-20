import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/models/token_pair/token_pair.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TokenPairItem extends StatefulWidget {
  final AssetToken assetToken;

  const TokenPairItem({super.key, required this.assetToken});

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
        contentPadding: const EdgeInsets.all(10),
        titleAlignment: ListTileTitleAlignment.center,
        leading: isLoading ? const CircularProgressIndicator(color: Colors.black38) : _getLeadingIcon(),
        title: Text(
          isLoading ? '' : widget.assetToken.symbol,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: isLoading
            ? const Text('')
            : Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                    isLoading ? '' : 'price: \$${tokenPair.priceUsd}\nbag: ${widget.assetToken.bagSize}\ntotal: ${_getCapital()}',
                    style: const TextStyle(height: 1.4)),
              ));
  }

  @override
  void initState() {
    super.initState();
    _loadTokenData();
  }

  void _loadTokenData() async {
    const dexScreenerService = DexScreenerService();
    TokenPair tokenPair = await dexScreenerService.getTokenPair(widget.assetToken);
    setState(() {
      this.tokenPair = tokenPair;
      isLoading = false;
    });
  }

  Widget _getLeadingIcon() {
    Widget img;
    if (widget.assetToken.icon.endsWith('.svg')) {
      img = SvgPicture.asset(widget.assetToken.icon);
    } else {
      img = Image.asset(widget.assetToken.icon);
    }
    return Container(width: 64.0, height: 64.0, child: img);
  }

  String _getCapital() {
    double capital = (widget.assetToken.bagSize * (tokenPair.priceUsd ?? 0.00));
    return NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 2).format(capital);
  }
}
