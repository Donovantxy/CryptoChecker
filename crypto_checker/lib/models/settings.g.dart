// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 2;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings(
      orderBy: fields[0] as OrderBy,
      sortingOrder: fields[1] as SortingOrder,
    )..coinMarketCapApiKey = fields[2] == null ? '' : fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.orderBy)
      ..writeByte(1)
      ..write(obj.sortingOrder)
      ..writeByte(2)
      ..write(obj.coinMarketCapApiKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OrderByAdapter extends TypeAdapter<OrderBy> {
  @override
  final int typeId = 3;

  @override
  OrderBy read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return OrderBy.price;
      case 1:
        return OrderBy.bagSize;
      case 2:
        return OrderBy.symbol;
      case 3:
        return OrderBy.percD;
      case 4:
        return OrderBy.percW;
      case 5:
        return OrderBy.percM;
      case 6:
        return OrderBy.capital;
      default:
        return OrderBy.price;
    }
  }

  @override
  void write(BinaryWriter writer, OrderBy obj) {
    switch (obj) {
      case OrderBy.price:
        writer.writeByte(0);
        break;
      case OrderBy.bagSize:
        writer.writeByte(1);
        break;
      case OrderBy.symbol:
        writer.writeByte(2);
        break;
      case OrderBy.percD:
        writer.writeByte(3);
        break;
      case OrderBy.percW:
        writer.writeByte(4);
        break;
      case OrderBy.percM:
        writer.writeByte(5);
        break;
      case OrderBy.capital:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderByAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SortingOrderAdapter extends TypeAdapter<SortingOrder> {
  @override
  final int typeId = 4;

  @override
  SortingOrder read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SortingOrder.asc;
      case 1:
        return SortingOrder.desc;
      default:
        return SortingOrder.asc;
    }
  }

  @override
  void write(BinaryWriter writer, SortingOrder obj) {
    switch (obj) {
      case SortingOrder.asc:
        writer.writeByte(0);
        break;
      case SortingOrder.desc:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortingOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
