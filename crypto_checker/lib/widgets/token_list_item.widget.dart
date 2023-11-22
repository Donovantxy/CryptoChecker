import 'dart:async';

import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/models/token_pair/token_pair.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:crypto_checker/widgets/bag_setting_dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenPairItem extends StatefulWidget {
  final TokenAsset tokenAsset;

  const TokenPairItem({super.key, required this.tokenAsset});

  @override
  State<TokenPairItem> createState() => _TokenPairItemState();
}

class _TokenPairItemState extends State<TokenPairItem> with AutomaticKeepAliveClientMixin<TokenPairItem> {
  late TokenPair tokenPair;
  bool isLoading = true;
  Timer? _timer;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        titleAlignment: ListTileTitleAlignment.center,
        leading: isLoading ? const CircularProgressIndicator(color: Colors.black38) : _getLeadingIcon(),
        title: Text(
          isLoading ? '' : widget.tokenAsset.symbol,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: isLoading
            ? const Text('')
            : Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Text(
                    isLoading
                        ? ''
                        : 'price: \$${tokenPair.priceUsd}\nbag: ${widget.tokenAsset.bagSize}\ntotal: ${_getAsset()}',
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

  @override
  void initState() {
    super.initState();
    _loadTokenData();
    _periodicPriceRefresh();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _periodicPriceRefresh() {
    _timer = Timer.periodic(const Duration(minutes: 5), (_) {
      _loadTokenData(isRefreshing: true);
    });
  }

  void _loadTokenData({bool isRefreshing = false}) async {
    const dexScreenerService = DexScreenerService();
    TokenPair tokenPair = await dexScreenerService.getTokenPair(widget.tokenAsset);
    int bagSize = isRefreshing ? widget.tokenAsset.bagSize : await _getBagSizeFromPrefs();
    setState(() {
      this.tokenPair = tokenPair;
      if (bagSize != -1) {
        widget.tokenAsset.bagSize = bagSize;
      }
      isLoading = false;
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

  String _getAsset() {
    double capital = (widget.tokenAsset.bagSize * (tokenPair.priceUsd ?? 0.00));
    return NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 2).format(capital);
  }

  BagSettingDialogWidget _showBagSettingDialog(BuildContext context, String symbol) {
    return BagSettingDialogWidget(
      tokenSymbol: symbol,
      onBagSettingSubmit: (int amount) async {
        _saveBagSizeToPrefs(amount);
        setState(() {
          widget.tokenAsset.bagSize = amount;
        });
      },
    );
  }

  void _saveBagSizeToPrefs(int amount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(widget.tokenAsset.symbol, amount);
  }

  Future<int> _getBagSizeFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(widget.tokenAsset.symbol) ?? -1;
  }
}
