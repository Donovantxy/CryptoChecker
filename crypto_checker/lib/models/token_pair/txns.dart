import 'h1.dart';
import 'h24.dart';
import 'h6.dart';
import 'm5.dart';

class Txns {
  H24? h24;
  H6? h6;
  H1? h1;
  M5? m5;

  Txns({this.h24, this.h6, this.h1, this.m5});

  factory Txns.fromJson(Map<String, dynamic> json) => Txns(
        h24: json['h24'] == null
            ? null
            : H24.fromJson(json['h24'] as Map<String, dynamic>),
        h6: json['h6'] == null
            ? null
            : H6.fromJson(json['h6'] as Map<String, dynamic>),
        h1: json['h1'] == null
            ? null
            : H1.fromJson(json['h1'] as Map<String, dynamic>),
        m5: json['m5'] == null
            ? null
            : M5.fromJson(json['m5'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'h24': h24?.toJson(),
        'h6': h6?.toJson(),
        'h1': h1?.toJson(),
        'm5': m5?.toJson(),
      };
}
