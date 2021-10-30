// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locator_tag.dart';

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
