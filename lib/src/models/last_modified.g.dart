// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_modified.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LastModifiedAdapter extends TypeAdapter<LastModified> {
  @override
  final int typeId = 6;

  @override
  LastModified read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LastModified(
      lastModified: fields[0] as String?,
      updateTime: fields[1] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, LastModified obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lastModified)
      ..writeByte(1)
      ..write(obj.updateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastModifiedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
