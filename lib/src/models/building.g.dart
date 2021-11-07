// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Building _$BuildingFromJson(Map<String, dynamic> json) {
  return Building(
    floorPlans: (json['floorPlans'] as List<dynamic>?)
        ?.map((e) => FloorPlan.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as int?,
    name: json['name'] as String?,
    distanceTo: (json['distanceTo'] as num?)?.toDouble(),
    lat: (json['lat'] as num?)?.toDouble(),
    lng: (json['lng'] as num?)?.toDouble(),
    managerId: json['managerId'] as int?,
    adminId: json['adminId'] as int?,
    numberOfFloor: json['numberOfFloor'] as int?,
    imageUrl: json['imageUrl'] as String?,
    address: json['address'] as String?,
  );
}

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'id': instance.id,
      'managerId': instance.managerId,
      'adminId': instance.adminId,
      'numberOfFloor': instance.numberOfFloor,
      'distanceTo': instance.distanceTo,
      'lat': instance.lat,
      'lng': instance.lng,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'address': instance.address,
      'floorPlans': instance.floorPlans,
    };
