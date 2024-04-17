import 'base_token.dart';
import 'liquidity.dart';
import 'price_change.dart';
import 'quote_token.dart';
import 'txns.dart';
import 'volume.dart';

class QuotesLatest {
  int id;
  String name;
  String symbol;
  double usd;
  double percDay;

  QuotesLatest({
    required this.id,
    required this.name,
    required this.symbol,
    required this.usd,
    required this.percDay
  });

  factory QuotesLatest.fromJson(Map<String, dynamic> json) => QuotesLatest(
    id: json['id'],
    name: json['name'],
    symbol: json['symbol'],
    usd: json['quote']['USD']['price'],
    percDay: json['quote']['USD']['percent_change_24h']
  );

  @override
  String toString() => 'Quotes \n$id - $name - $symbol - $usd - $percDay';

}

class TokenPair {
  String? chainId;
  String? dexId;
  String? url;
  String? pairAddress;
  BaseToken? baseToken;
  QuoteToken? quoteToken;
  String? priceNative;
  double? priceUsd;
  Txns? txns;
  Volume? volume;
  PriceChange? priceChange;
  Liquidity? liquidity;
  num? fdv;

  TokenPair({
    this.chainId,
    this.dexId,
    this.url,
    this.pairAddress,
    this.baseToken,
    this.quoteToken,
    this.priceNative,
    this.priceUsd,
    this.txns,
    this.volume,
    this.priceChange,
    this.liquidity,
    this.fdv,
  });

  factory TokenPair.fromJson(Map<String, dynamic> json) => TokenPair(
        chainId: json['chainId'] as String?,
        dexId: json['dexId'] as String?,
        url: json['url'] as String?,
        pairAddress: json['pairAddress'] as String?,
        baseToken: json['baseToken'] == null
            ? null
            : BaseToken.fromJson(json['baseToken'] as Map<String, dynamic>),
        quoteToken: json['quoteToken'] == null
            ? null
            : QuoteToken.fromJson(json['quoteToken'] as Map<String, dynamic>),
        priceNative: json['priceNative'] as String?,
        priceUsd: json['priceUsd'] != null ? double.tryParse(json['priceUsd']) ?? 0.0 : 0.0,
        txns: json['txns'] == null
            ? null
            : Txns.fromJson(json['txns'] as Map<String, dynamic>),
        volume: json['volume'] == null
            ? null
            : Volume.fromJson(json['volume'] as Map<String, dynamic>),
        priceChange: json['priceChange'] == null
            ? null
            : PriceChange.fromJson(json['priceChange'] as Map<String, dynamic>),
        liquidity: json['liquidity'] == null
            ? null
            : Liquidity.fromJson(json['liquidity'] as Map<String, dynamic>),
        fdv: (json['fdv'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'chainId': url,
        'dexId': url,
        'url': url,
        'pairAddress': pairAddress,
        'baseToken': baseToken?.toJson(),
        'quoteToken': quoteToken?.toJson(),
        'priceNative': priceNative,
        'priceUsd': priceUsd,
        'txns': txns?.toJson(),
        'volume': volume?.toJson(),
        'priceChange': priceChange?.toJson(),
        'liquidity': liquidity?.toJson(),
        'fdv': fdv,
      };

  @override
  String toString() =>
      'Symbol: ${baseToken?.symbol}, ChainId: $chainId, Name: ${baseToken?.name}, Price: ${quoteToken?.symbol} $priceUsd\n';
}
