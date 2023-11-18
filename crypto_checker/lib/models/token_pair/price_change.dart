class PriceChange {
  num? h24;
  num? h6;
  num? h1;
  num? m5;

  PriceChange({this.h24, this.h6, this.h1, this.m5});

  factory PriceChange.fromJson(Map<String, dynamic> json) => PriceChange(
        h24: (json['h24'] as num?)?.toDouble(),
        h6: (json['h6'] as num?)?.toDouble(),
        h1: (json['h1'] as num?)?.toDouble(),
        m5: (json['m5'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'h24': h24,
        'h6': h6,
        'h1': h1,
        'm5': m5,
      };
}
