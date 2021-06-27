import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'floor_plan.g.dart';

@JsonSerializable()
class FloorPlan {
  final int? id, floorNumber, buildingId;
  final String? floorCode, floorNum, imageUrl;
  final List<Location>? locations;

  FloorPlan({
    this.locations,
    this.floorNumber,
    this.buildingId,
    this.imageUrl,
    this.id,
    this.floorCode,
    this.floorNum,
  });
  factory FloorPlan.fromJson(Map<String, dynamic> json) =>
      _$FloorPlanFromJson(json);

  Map<String, dynamic> toJson() => _$FloorPlanToJson(this);
}
