class H24 {
  num?buys;
  num?sells;

  H24({this.buys, this.sells});

  factory H24.fromJson(Map<String, dynamic> json) => H24(
        buys: json['buys'] as int?,
        sells: json['sells'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'buys': buys,
        'sells': sells,
      };
}
