import 'package:crypto_checker/models/settings.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'asset_token.g.dart';

@HiveType(typeId: 0)
class TokenAsset extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String symbol;
  String? icon;
  @HiveField(2)
  double bagSize;
  @HiveField(3)
  double price;
  @HiveField(4)
  bool isVisible;
  double percentage;

  TokenAsset({
    required this.id,
    required this.symbol,
    this.icon,
    this.bagSize = 0,
    this.price = 0.00,
    this.isVisible = true,
    this.percentage = 0.00
  });

  TokenAsset copyWith({
    int? id,
    String? symbol,
    String? icon,
    double? bagSize,
    double? price,
    bool? isVisible,
  }) {
    return TokenAsset(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      icon: icon ?? this.icon,
      bagSize: bagSize ?? this.bagSize,
      price: price ?? this.price,
      isVisible: isVisible ?? this.isVisible,
      percentage: 0.00
    );
  }

  @override
  String toString() => '$id - $symbol - $price - $bagSize - $isVisible';

  static sortByPrice(List<TokenAsset> tokens,
      {SortingOrder isAsc = SortingOrder.desc}) {
    tokens.sort((TokenAsset a, TokenAsset b) {
      return isAsc == SortingOrder.asc
          ? a.price.compareTo(b.price)
          : b.price.compareTo(a.price);
    });
  }
  
  static sortByPerc(List<TokenAsset> tokens,
      {SortingOrder isAsc = SortingOrder.desc}) {
    tokens.sort((TokenAsset a, TokenAsset b) {
      return isAsc == SortingOrder.asc
          ? a.percentage.compareTo(b.percentage)
          : b.percentage.compareTo(a.percentage);
    });
  }

  static sortBySymbol(List<TokenAsset> tokens,
      {SortingOrder isAsc = SortingOrder.asc}) {
    tokens.sort((TokenAsset a, TokenAsset b) => isAsc == SortingOrder.asc
        ? a.symbol.toLowerCase().compareTo(b.symbol.toLowerCase())
        : b.symbol.toLowerCase().compareTo(a.symbol.toLowerCase()));
  }

  static sortByAmount(List<TokenAsset> tokens,
      {SortingOrder isAsc = SortingOrder.desc}) {
    tokens.sort((TokenAsset a, TokenAsset b) => isAsc == SortingOrder.asc
        ? a.bagSize.compareTo(b.bagSize)
        : b.bagSize.compareTo(a.bagSize));
  }
}

mixin TokenAssetList {
  static List<TokenAsset> getOne() {
    return [
      TokenAsset(
          id: 1, symbol: 'BTC', icon: 'assets/images/token_icons/BTC.png'),
    ];
  }

  static List<TokenAsset> get() {
    return [
      TokenAsset(
        id: 1,
        symbol: 'BTC',
        icon: 'assets/images/token_icons/BTC.png',
      ),
      TokenAsset(
        id: 1027,
        symbol: 'ETH',
        icon: 'assets/images/token_icons/ETH.png',
      ),
      TokenAsset(
        id: 52,
        symbol: 'XRP',
        icon: 'assets/images/token_icons/XRP.png',
      ),
      TokenAsset(
        id: 5426,
        symbol: 'SOL',
        icon: 'assets/images/token_icons/SOL.png',
      ),
      TokenAsset(
        id: 2010,
        symbol: 'ADA',
        icon: 'assets/images/token_icons/ADA.png',
      ),
      TokenAsset(
        id: 3077,
        symbol: 'VET',
        icon: 'assets/images/token_icons/VET.png',
      ),
      TokenAsset(
        id: 74,
        symbol: 'DOGE',
        icon: 'assets/images/token_icons/DOGE.png',
      ),
      TokenAsset(
        id: 3890,
        symbol: 'MATIC',
        icon: 'assets/images/token_icons/MATIC.png',
      ),
      TokenAsset(
        id: 6210,
        symbol: 'SAND',
        icon: 'assets/images/token_icons/SAND.png',
      ),
      TokenAsset(
        id: 7080,
        symbol: 'GALA',
        icon: 'assets/images/token_icons/GALA.png',
      ),
      TokenAsset(
        id: 11145,
        symbol: 'PLS',
        icon: 'assets/images/token_icons/WPLS.svg',
      ),
      TokenAsset(
        id: 28928,
        symbol: 'HEX',
        icon: 'assets/images/token_icons/HEX.png',
      ),
      TokenAsset(
        id: 5015,
        symbol: 'eHEX',
        icon: 'assets/images/token_icons/eHEX.png',
      ),
      TokenAsset(
        id: 4038,
        symbol: 'MBL',
        icon: 'assets/images/token_icons/MBL.png',
      ),
      TokenAsset(
        id: 512,
        symbol: 'XLM',
        icon: 'assets/images/token_icons/XLM.svg',
      ),
      TokenAsset(
        id: 5805,
        symbol: 'AVAX',
        icon: 'assets/images/token_icons/AVAX.svg',
      ),
      TokenAsset(
        id: 1975,
        symbol: 'LINK',
        icon: 'assets/images/token_icons/LINK.png',
      ),
      TokenAsset(
        id: 3155,
        symbol: 'QNT',
        icon: 'assets/images/token_icons/QNT.svg',
      ),
    ];
  }
}
