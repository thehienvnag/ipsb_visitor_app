// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 0;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      id: fields[0] as int?,
      locationTypeId: fields[1] as int?,
      storeId: fields[2] as int?,
      floorPlanId: fields[3] as int?,
      floorPlan: fields[8] as FloorPlan?,
      x: fields[4] as double?,
      y: fields[5] as double?,
      locationType: fields[6] as LocationType?,
      store: fields[7] as Store?,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.locationTypeId)
      ..writeByte(2)
      ..write(obj.storeId)
      ..writeByte(3)
      ..write(obj.floorPlanId)
      ..writeByte(4)
      ..write(obj.x)
      ..writeByte(5)
      ..write(obj.y)
      ..writeByte(6)
      ..write(obj.locationType)
      ..writeByte(7)
      ..write(obj.store)
      ..writeByte(8)
      ..write(obj.floorPlan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    id: json['id'] as int?,
    locationTypeId: json['locationTypeId'] as int?,
    storeId: json['storeId'] as int?,
    floorPlanId: json['floorPlanId'] as int?,
    floorPlan: json['floorPlan'] == null
        ? null
        : FloorPlan.fromJson(json['floorPlan'] as Map<String, dynamic>),
    x: (json['x'] as num?)?.toDouble(),
    y: (json['y'] as num?)?.toDouble(),
    locationType: json['locationType'] == null
        ? null
        : LocationType.fromJson(json['locationType'] as Map<String, dynamic>),
    store: json['store'] == null
        ? null
        : Store.fromJson(json['store'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'locationTypeId': instance.locationTypeId,
      'storeId': instance.storeId,
      'floorPlanId': instance.floorPlanId,
      'x': instance.x,
      'y': instance.y,
      'locationType': instance.locationType,
      'store': instance.store,
      'floorPlan': instance.floorPlan,
    };
