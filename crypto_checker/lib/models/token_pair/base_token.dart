class BaseToken {
  String? address;
  String? name;
  String? symbol;

  BaseToken({this.address, this.name, this.symbol});

  factory BaseToken.fromJson(Map<String, dynamic> json) => BaseToken(
        address: json['address'] as String?,
        name: json['name'] as String?,
        symbol: json['symbol'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'address': address,
        'name': name,
        'symbol': symbol,
      };
}
