// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateHiveAdapter extends TypeAdapter<DateHive> {
  @override
  final int typeId = 0;

  @override
  DateHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateHive(
      name: fields[0] as String,
      date: fields[1] as DateTime,
      done: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, DateHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.done);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
