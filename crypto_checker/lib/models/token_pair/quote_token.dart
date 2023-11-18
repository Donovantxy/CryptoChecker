class QuoteToken {
  String? symbol;

  QuoteToken({this.symbol});

  factory QuoteToken.fromJson(Map<String, dynamic> json) => QuoteToken(
        symbol: json['symbol'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
      };
}
