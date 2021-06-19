import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edge.g.dart';

@JsonSerializable()
class Edge {
  final int? id, fromLocationId, toLocationId;
  final Location? fromLocation, toLocation;
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
