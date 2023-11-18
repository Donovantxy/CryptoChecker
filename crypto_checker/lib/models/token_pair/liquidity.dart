class Liquidity {
  num? usd;
  num? base;
  num? quote;

  Liquidity({this.usd, this.base, this.quote});

  factory Liquidity.fromJson(Map<String, dynamic> json) => Liquidity(
        usd: json['usd'],
        base: json['usd'],
        quote: json['usd'],
      );

  Map<String, dynamic> toJson() => {
        'usd': usd,
        'base': base,
        'quote': quote,
      };
}
