class H1 {
  num?buys;
  num?sells;

  H1({this.buys, this.sells});

  factory H1.fromJson(Map<String, dynamic> json) => H1(
        buys: json['buys'] as int?,
        sells: json['sells'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'buys': buys,
        'sells': sells,
      };
}
