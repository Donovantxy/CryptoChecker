import 'package:crypto_checker/models/settings.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'asset_token.g.dart';

@HiveType(typeId: 0)
class TokenAsset extends HiveObject {
  @HiveField(0)
  String symbol;
  String? icon;
  @HiveField(1)
  double bagSize;
  @HiveField(2)
  double price;
  String? chainId;
  String? pairAddress;
  @HiveField(3)
  bool isVisible;

  TokenAsset({
    required this.symbol,
    this.icon,
    this.bagSize = 0,
    this.price = 0.00,
    this.isVisible = true,
    this.chainId,
    this.pairAddress,
  });

  TokenAsset copyWith({
    String? symbol,
    String? icon,
    double? bagSize,
    double? price,
    String? chainId,
    String? pairAddress,
    bool? isVisible,
  }) {
    return TokenAsset(
      symbol: symbol ?? this.symbol,
      icon: icon ?? this.icon,
      bagSize: bagSize ?? this.bagSize,
      price: price ?? this.price,
      chainId: chainId ?? this.chainId,
      pairAddress: pairAddress ?? this.pairAddress,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  @override
  String toString() => '$symbol - $price - $bagSize - $isVisible';

  static sortByPrice(List<TokenAsset> tokens, {SortingOrder isAsc = SortingOrder.desc}) {
    tokens.sort((TokenAsset a, TokenAsset b) {
      return isAsc == SortingOrder.asc ? a.price.compareTo(b.price) : b.price.compareTo(a.price);
    });
  }

  static sortBySymbol(List<TokenAsset> tokens, {SortingOrder isAsc = SortingOrder.asc}) {
    tokens.sort((TokenAsset a, TokenAsset b) => isAsc == SortingOrder.asc
        ? a.symbol.toLowerCase().compareTo(b.symbol.toLowerCase())
        : b.symbol.toLowerCase().compareTo(a.symbol.toLowerCase()));
  }

  static sortByAmount(List<TokenAsset> tokens, {SortingOrder isAsc = SortingOrder.desc}) {
    tokens.sort((TokenAsset a, TokenAsset b) => isAsc == SortingOrder.asc ? a.bagSize.compareTo(b.bagSize) : b.bagSize.compareTo(a.bagSize));
  }
}

mixin TokenAssetList {
  static List<TokenAsset> getOne() {
    return [
      TokenAsset(symbol: 'BTC', icon: 'assets/images/token_icons/BTC.png', chainId: 'bsc', pairAddress: '0x8fE557749165ADF5F387Ad71CE0cFaB597348624'),
    ];
  }

  static List<TokenAsset> get() {
    return [
      TokenAsset(
          symbol: 'BTC', icon: 'assets/images/token_icons/BTC.png', chainId: 'avalanche', pairAddress: '0x2fD81391E30805Cc7F2Ec827013ce86dc591B806'),
      TokenAsset(
          symbol: 'ETH', icon: 'assets/images/token_icons/ETH.png', chainId: 'ethereum', pairAddress: '0xc7bBeC68d12a0d1830360F8Ec58fA599bA1b0e9b'),
      TokenAsset(symbol: 'XRP', icon: 'assets/images/token_icons/XRP.png', chainId: 'bsc', pairAddress: '0x86746cc10BA1422CB17483748105d1d1DF5A2876'),
      TokenAsset(symbol: 'SOL', icon: 'assets/images/token_icons/SOL.png', chainId: 'bsc', pairAddress: '0xAe08C9D357731FD8d25681dE753551BE14C00405'),
      TokenAsset(symbol: 'ADA', icon: 'assets/images/token_icons/ADA.png', chainId: 'bsc', pairAddress: '0xcb2828964FDa6A0eC8ed1C0b95E73A5eE58CF16A'),
      TokenAsset(symbol: 'VET', icon: 'assets/images/token_icons/VET.png', chainId: 'bsc', pairAddress: '0x9fcA1DcE9E0487336355C6485327Cd8728147c18'),
      TokenAsset(
          symbol: 'DOGE', icon: 'assets/images/token_icons/DOGE.png', chainId: 'ethereum', pairAddress: '0xfCd13EA0B906f2f87229650b8D93A51B2e839EBD'),
      TokenAsset(
          symbol: 'MATIC',
          icon: 'assets/images/token_icons/MATIC.png',
          chainId: 'ethereum',
          pairAddress: '0x99C7550be72F05ec31c446cD536F8a29C89fdB77'),
      TokenAsset(
          symbol: 'SAND', icon: 'assets/images/token_icons/SAND.png', chainId: 'bsc', pairAddress: '0x69f60c87AEcdb037A44cbaD67eD06464432521b6'),
      TokenAsset(
          symbol: 'GALA', icon: 'assets/images/token_icons/GALA.png', chainId: 'ethereum', pairAddress: '0x86b7A8Bf03167ee42b983b383c9D0182FCC07841'),
      TokenAsset(
          symbol: 'WPLS',
          icon: 'assets/images/token_icons/WPLS.svg',
          chainId: 'pulsechain',
          pairAddress: '0xE56043671df55dE5CDf8459710433C10324DE0aE'),
      TokenAsset(
          symbol: 'eHEX', icon: 'assets/images/token_icons/eHEX.png', chainId: 'ethereum', pairAddress: '0x69D91B94f0AaF8e8A2586909fA77A5c2c89818d5'),
      TokenAsset(symbol: 'MBL', icon: 'assets/images/token_icons/MBL.png', chainId: 'bsc', pairAddress: '0x863B7B21ff4CA0782F886D929F3E19522e6Cd8a0'),
      TokenAsset(symbol: 'XLM', icon: 'assets/images/token_icons/XLM.svg', chainId: 'bsc', pairAddress: '0xA6c273efA963bDcb09454B40a3d0d4e25AFd8745'),
      TokenAsset(
          symbol: 'AVAX', icon: 'assets/images/token_icons/AVAX.svg', chainId: 'bsc', pairAddress: '0x1da8b1aD522EaFFF6B134E46F6dEdd397Fc4F76C'),
      TokenAsset(
          symbol: 'LINK', icon: 'assets/images/token_icons/LINK.png', chainId: 'arbitrum', pairAddress: '0x655C1607F8c2E73D5b4ddAbCe9Ba8792b87592B6'),
      TokenAsset(
          symbol: 'QNT', icon: 'assets/images/token_icons/QNT.svg', chainId: 'hedera', pairAddress: '0x824Ab670fa8954B781101722E96d1E2351C95B7e'),
    ];
  }
}
