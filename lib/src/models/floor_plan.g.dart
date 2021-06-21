// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorPlan _$FloorPlanFromJson(Map<String, dynamic> json) {
  return FloorPlan(
    floorNumber: json['floorNumber'] as int?,
    buildingId: json['buildingId'] as int?,
    imageUrl: json['imageUrl'] as String?,
    id: json['id'] as int?,
    floorCode: json['floorCode'] as String?,
    floorNum: json['floorNum'] as String?,
  );
}

Map<String, dynamic> _$FloorPlanToJson(FloorPlan instance) => <String, dynamic>{
      'id': instance.id,
      'floorNumber': instance.floorNumber,
      'buildingId': instance.buildingId,
      'floorCode': instance.floorCode,
      'floorNum': instance.floorNum,
      'imageUrl': instance.imageUrl,
    };
