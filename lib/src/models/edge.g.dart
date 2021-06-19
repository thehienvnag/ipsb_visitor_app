// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edge.dart';

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
