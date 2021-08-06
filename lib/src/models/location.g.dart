// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

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
