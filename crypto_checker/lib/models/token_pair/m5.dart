class M5 {
  num?buys;
  num?sells;

  M5({this.buys, this.sells});

  factory M5.fromJson(Map<String, dynamic> json) => M5(
        buys: json['buys'] as int?,
        sells: json['sells'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'buys': buys,
        'sells': sells,
      };
}
