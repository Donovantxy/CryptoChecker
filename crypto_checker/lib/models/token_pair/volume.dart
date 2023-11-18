class Volume {
  num? h24;
  num? h6;
  num? h1;
  num? m5;

  Volume({this.h24, this.h6, this.h1, this.m5});

  factory Volume.fromJson(Map<String, dynamic> json) => Volume(
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
