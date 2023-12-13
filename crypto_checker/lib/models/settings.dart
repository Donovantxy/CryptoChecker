import 'package:hive_flutter/hive_flutter.dart';

part 'settings.g.dart';

@HiveType(typeId: 3)
enum OrderBy {
  @HiveField(0)
  price,
  @HiveField(1)
  bagSize,
  @HiveField(2)
  symbol
}

@HiveType(typeId: 4)
enum SortingOrder {
  @HiveField(0)
  asc,
  @HiveField(1)
  desc
}

@HiveType(typeId: 2)
class Settings extends HiveObject {
  @HiveField(0)
  OrderBy orderBy;
  @HiveField(1)
  SortingOrder sortingOrder;
  final Map<OrderBy, String> orderByLabel = {
    OrderBy.price: 'Price',
    OrderBy.bagSize: 'Bag',
    OrderBy.symbol: 'Name',
  };

  Settings({this.orderBy = OrderBy.price, this.sortingOrder = SortingOrder.desc});

  @override
  String toString() => 'orderBy: ${orderByLabel[orderBy]} - ASC: ${sortingOrder == SortingOrder.asc}';
}
