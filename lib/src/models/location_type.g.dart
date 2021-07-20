// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationType _$LocationTypeFromJson(Map<String, dynamic> json) {
  return LocationType(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    imageUrl: json['imageUrl'] as String?,
  );
}

Map<String, dynamic> _$LocationTypeToJson(LocationType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
