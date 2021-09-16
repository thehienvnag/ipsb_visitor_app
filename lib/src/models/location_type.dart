import 'package:hive/hive.dart';
import 'package:visitor_app/src/common/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_type.g.dart';

@JsonSerializable()
@HiveType(typeId: AppHiveType.locationType)
class LocationType {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? imageUrl;
  LocationType({this.id, this.name, this.description, this.imageUrl});

  factory LocationType.fromJson(Map<String, dynamic> json) =>
      _$LocationTypeFromJson(json);

  Map<String, dynamic> toJson() => _$LocationTypeToJson(this);
}
