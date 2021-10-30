// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FloorPlanAdapter extends TypeAdapter<FloorPlan> {
  @override
  final int typeId = 2;

  @override
  FloorPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FloorPlan(
      id: fields[0] as int?,
      floorNumber: fields[1] as int?,
      buildingId: fields[2] as int?,
      floorCode: fields[3] as String?,
      mapScale: fields[4] as double?,
      rotationAngle: fields[5] as double?,
      imageUrl: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FloorPlan obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.floorNumber)
      ..writeByte(2)
      ..write(obj.buildingId)
      ..writeByte(3)
      ..write(obj.floorCode)
      ..writeByte(4)
      ..write(obj.mapScale)
      ..writeByte(5)
      ..write(obj.rotationAngle)
      ..writeByte(6)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FloorPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorPlan _$FloorPlanFromJson(Map<String, dynamic> json) {
  return FloorPlan(
    id: json['id'] as int?,
    floorNumber: json['floorNumber'] as int?,
    buildingId: json['buildingId'] as int?,
    floorCode: json['floorCode'] as String?,
    mapScale: (json['mapScale'] as num?)?.toDouble(),
    rotationAngle: (json['rotationAngle'] as num?)?.toDouble(),
    imageUrl: json['imageUrl'] as String?,
  );
}

Map<String, dynamic> _$FloorPlanToJson(FloorPlan instance) => <String, dynamic>{
      'id': instance.id,
      'floorNumber': instance.floorNumber,
      'buildingId': instance.buildingId,
      'floorCode': instance.floorCode,
      'mapScale': instance.mapScale,
      'rotationAngle': instance.rotationAngle,
      'imageUrl': instance.imageUrl,
    };
