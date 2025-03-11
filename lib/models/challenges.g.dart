// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenges.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChallengeAdapter extends TypeAdapter<Challenge> {
  @override
  final int typeId = 0;

  @override
  Challenge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Challenge(
      title: fields[0] as String,
      tasks: (fields[1] as List).cast<Task>(),
      flowerType: fields[2] as FlowerType,
    );
  }

  @override
  void write(BinaryWriter writer, Challenge obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.tasks)
      ..writeByte(2)
      ..write(obj.flowerType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallengeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FlowerTypeAdapter extends TypeAdapter<FlowerType> {
  @override
  final int typeId = 1;

  @override
  FlowerType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FlowerType.peony;
      case 1:
        return FlowerType.pansy;
      case 2:
        return FlowerType.iris;
      default:
        return FlowerType.peony;
    }
  }

  @override
  void write(BinaryWriter writer, FlowerType obj) {
    switch (obj) {
      case FlowerType.peony:
        writer.writeByte(0);
        break;
      case FlowerType.pansy:
        writer.writeByte(1);
        break;
      case FlowerType.iris:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlowerTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
