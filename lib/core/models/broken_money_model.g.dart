// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broken_money_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrokenMoneyModelAdapter extends TypeAdapter<BrokenMoneyModel> {
  @override
  final int typeId = 0;

  @override
  BrokenMoneyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrokenMoneyModel(
      brokenMoney_1: fields[0] as double?,
      brokenMoney_050: fields[1] as double?,
      brokenMoney_025: fields[2] as double?,
      brokenMoney_010: fields[3] as double?,
      brokenMoney_005: fields[4] as double?,
      date: fields[5] as String?,
      totalMoney: fields[6] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, BrokenMoneyModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.brokenMoney_1)
      ..writeByte(1)
      ..write(obj.brokenMoney_050)
      ..writeByte(2)
      ..write(obj.brokenMoney_025)
      ..writeByte(3)
      ..write(obj.brokenMoney_010)
      ..writeByte(4)
      ..write(obj.brokenMoney_005)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.totalMoney);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrokenMoneyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
