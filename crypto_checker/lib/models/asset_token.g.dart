// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenAssetAdapter extends TypeAdapter<TokenAsset> {
  @override
  final int typeId = 0;

  @override
  TokenAsset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenAsset(
      id: fields[0] as int,
      symbol: fields[1] as String,
      bagSize: fields[2] as double,
      price: fields[3] as double,
      isVisible: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TokenAsset obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.bagSize)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.isVisible);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAssetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
