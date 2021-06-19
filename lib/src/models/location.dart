import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int? id, locationTypeId, storeId, floorPlanId;
  final double? x, y;
  Location({
    this.id,
    this.locationTypeId,
    this.storeId,
    this.floorPlanId,
    this.x,
    this.y,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString() {
    return '{id=$id __ ($x, $y)}';
  }
}
