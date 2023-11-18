class H6 {
  num?buys;
  num?sells;

  H6({this.buys, this.sells});

  factory H6.fromJson(Map<String, dynamic> json) => H6(
        buys: json['buys'] as int?,
        sells: json['sells'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'buys': buys,
        'sells': sells,
      };
}
