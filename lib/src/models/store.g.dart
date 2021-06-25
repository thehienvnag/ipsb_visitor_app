// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    floorPlan: json['floorPlan'] == null
        ? null
        : FloorPlan.fromJson(json['floorPlan'] as Map<String, dynamic>),
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    imageUrl: json['imageUrl'] as String?,
    floorPlanId: json['floorPlanId'] as int?,
    status: json['status'] as String?,
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'floorPlanId': instance.floorPlanId,
      'status': instance.status,
      'floorPlan': instance.floorPlan,
    };
