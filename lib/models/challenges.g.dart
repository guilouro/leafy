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
    );
  }

  @override
  void write(BinaryWriter writer, Challenge obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.tasks);
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
