// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanAdapter extends TypeAdapter<Plan> {
  @override
  final int typeId = 0;

  @override
  Plan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plan(
      hour: fields[0] as int,
      minute: fields[1] as int,
      planContent: fields[2] as String,
      day: fields[3] as int,
      isCheck: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Plan obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.minute)
      ..writeByte(2)
      ..write(obj.planContent)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.isCheck);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
