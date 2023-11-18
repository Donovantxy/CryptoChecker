import 'base_token.dart';
import 'liquidity.dart';
import 'price_change.dart';
import 'quote_token.dart';
import 'txns.dart';
import 'volume.dart';

class TokenPair {
  String? url;
  String? pairAddress;
  BaseToken? baseToken;
  QuoteToken? quoteToken;
  String? priceNative;
  String? priceUsd;
  Txns? txns;
  Volume? volume;
  PriceChange? priceChange;
  Liquidity? liquidity;
  num? fdv;

  TokenPair({
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
        url: json['url'] as String?,
        pairAddress: json['pairAddress'] as String?,
        baseToken: json['baseToken'] == null
            ? null
            : BaseToken.fromJson(json['baseToken'] as Map<String, dynamic>),
        quoteToken: json['quoteToken'] == null
            ? null
            : QuoteToken.fromJson(json['quoteToken'] as Map<String, dynamic>),
        priceNative: json['priceNative'] as String?,
        priceUsd: json['priceUsd'] as String?,
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
  String toString() => 'Symbol: ${baseToken?.symbol} Name: ${baseToken?.name} Quote token: ${quoteToken?.symbol} Price: $priceUsd\n';
  
}
