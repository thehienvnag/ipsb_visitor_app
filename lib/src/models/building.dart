import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building.g.dart';

@JsonSerializable()
class Building {
  final int? id, managerId, adminId, numberOfFloor;
  final double? distanceTo, lat, lng;
  final String? imageUrl, name;
  final String? address;
  final List<FloorPlan>? floorPlans;
  Building({
    this.floorPlans,
    this.id,
    this.name,
    this.distanceTo,
    this.lat,
    this.lng,
    this.managerId,
    this.adminId,
    this.numberOfFloor,
    this.imageUrl,
    this.address,
  });

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingToJson(this);
}
