
import 'package:hive_flutter/hive_flutter.dart';
part 'financial_record.g.dart';

@HiveType(typeId: 1)
class FinancialRecord extends HiveObject {
  @HiveField(0)
  String currency;
  @HiveField(1)
  int toReinvestPerc;
  @HiveField(2)
  int taxPerc;
  FinancialRecord({required this.currency, required this.taxPerc, required this.toReinvestPerc});
}