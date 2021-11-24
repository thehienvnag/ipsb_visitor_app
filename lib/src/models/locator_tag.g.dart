// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locator_tag.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocatorTagAdapter extends TypeAdapter<LocatorTag> {
  @override
  final int typeId = 9;

  @override
  LocatorTag read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocatorTag(
      id: fields[0] as int?,
      uuid: fields[1] as String?,
      txPower: fields[2] as double?,
      floorPlanId: fields[3] as int?,
      locatorTagGroupId: fields[4] as int?,
      locationId: fields[5] as int?,
      location: fields[6] as Location?,
      status: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocatorTag obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uuid)
      ..writeByte(2)
      ..write(obj.txPower)
      ..writeByte(3)
      ..write(obj.floorPlanId)
      ..writeByte(4)
      ..write(obj.locatorTagGroupId)
      ..writeByte(5)
      ..write(obj.locationId)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocatorTagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocatorTag _$LocatorTagFromJson(Map<String, dynamic> json) {
  return LocatorTag(
    id: json['id'] as int?,
    uuid: json['uuid'] as String?,
    txPower: (json['txPower'] as num?)?.toDouble(),
    floorPlanId: json['floorPlanId'] as int?,
    locatorTagGroupId: json['locatorTagGroupId'] as int?,
    locationId: json['locationId'] as int?,
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    status: json['status'] as String?,
  );
}

Map<String, dynamic> _$LocatorTagToJson(LocatorTag instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'txPower': instance.txPower,
      'floorPlanId': instance.floorPlanId,
      'locatorTagGroupId': instance.locatorTagGroupId,
      'locationId': instance.locationId,
      'location': instance.location,
      'status': instance.status,
    };
