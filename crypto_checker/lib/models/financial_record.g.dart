// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FinancialRecordAdapter extends TypeAdapter<FinancialRecord> {
  @override
  final int typeId = 1;

  @override
  FinancialRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FinancialRecord(
      currency: fields[0] as String,
      taxPerc: fields[2] as int,
      toReinvestPerc: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FinancialRecord obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.currency)
      ..writeByte(1)
      ..write(obj.toReinvestPerc)
      ..writeByte(2)
      ..write(obj.taxPerc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinancialRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
