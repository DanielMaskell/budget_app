// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentHiveAdapter extends TypeAdapter<PaymentHive> {
  @override
  final int typeId = 1;

  @override
  PaymentHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentHive(
      name: fields[0] as String,
      description: fields[1] as String?,
      type: fields[2] as String,
      date: fields[3] as DateTime,
      referenceId: fields[4] as String?,
      occurence: fields[5] as String,
      amount: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.referenceId)
      ..writeByte(5)
      ..write(obj.occurence)
      ..writeByte(6)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
