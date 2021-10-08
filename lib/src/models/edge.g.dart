// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EdgeAdapter extends TypeAdapter<Edge> {
  @override
  final int typeId = 3;

  @override
  Edge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Edge(
      id: fields[0] as int?,
      fromLocationId: fields[1] as int?,
      toLocationId: fields[2] as int?,
      fromLocation: fields[3] as Location?,
      toLocation: fields[4] as Location?,
      distance: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Edge obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fromLocationId)
      ..writeByte(2)
      ..write(obj.toLocationId)
      ..writeByte(3)
      ..write(obj.fromLocation)
      ..writeByte(4)
      ..write(obj.toLocation)
      ..writeByte(5)
      ..write(obj.distance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EdgeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Edge _$EdgeFromJson(Map<String, dynamic> json) {
  return Edge(
    id: json['id'] as int?,
    fromLocationId: json['fromLocationId'] as int?,
    toLocationId: json['toLocationId'] as int?,
    fromLocation: json['fromLocation'] == null
        ? null
        : Location.fromJson(json['fromLocation'] as Map<String, dynamic>),
    toLocation: json['toLocation'] == null
        ? null
        : Location.fromJson(json['toLocation'] as Map<String, dynamic>),
    distance: (json['distance'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$EdgeToJson(Edge instance) => <String, dynamic>{
      'id': instance.id,
      'fromLocationId': instance.fromLocationId,
      'toLocationId': instance.toLocationId,
      'fromLocation': instance.fromLocation,
      'toLocation': instance.toLocation,
      'distance': instance.distance,
    };
