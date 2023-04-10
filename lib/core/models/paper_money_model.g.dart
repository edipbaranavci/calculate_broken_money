// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper_money_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaperMoneyModelAdapter extends TypeAdapter<PaperMoneyModel> {
  @override
  final int typeId = 1;

  @override
  PaperMoneyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaperMoneyModel(
      papaperMoney5: fields[0] as int,
      papaperMoney10: fields[1] as int,
      papaperMoney20: fields[2] as int,
      papaperMoney50: fields[3] as int,
      papaperMoney100: fields[4] as int,
      papaperMoney200: fields[5] as int,
      totalMoney: fields[6] as int,
      date: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PaperMoneyModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.papaperMoney5)
      ..writeByte(1)
      ..write(obj.papaperMoney10)
      ..writeByte(2)
      ..write(obj.papaperMoney20)
      ..writeByte(3)
      ..write(obj.papaperMoney50)
      ..writeByte(4)
      ..write(obj.papaperMoney100)
      ..writeByte(5)
      ..write(obj.papaperMoney200)
      ..writeByte(6)
      ..write(obj.totalMoney)
      ..writeByte(7)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaperMoneyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
