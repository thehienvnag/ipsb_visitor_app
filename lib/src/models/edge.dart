import 'package:hive/hive.dart';
import 'package:indoor_positioning_visitor/src/common/constants.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edge.g.dart';

@JsonSerializable()
@HiveType(typeId: AppHiveType.edge)
class Edge {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final int? fromLocationId;

  @HiveField(2)
  final int? toLocationId;

  @HiveField(3)
  final Location? fromLocation;

  @HiveField(4)
  final Location? toLocation;

  @HiveField(5)
  final double? distance;
  Edge({
    this.id,
    this.fromLocationId,
    this.toLocationId,
    this.fromLocation,
    this.toLocation,
    this.distance,
  });

  @override
  String toString() {
    return '$id-$distance';
  }

  factory Edge.fromJson(Map<String, dynamic> json) => _$EdgeFromJson(json);

  Map<String, dynamic> toJson() => _$EdgeToJson(this);
}
