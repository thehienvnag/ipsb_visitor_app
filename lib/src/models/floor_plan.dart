import 'package:hive/hive.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'floor_plan.g.dart';

@JsonSerializable()
@HiveType(typeId: AppHiveType.floorPlan)
class FloorPlan {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final int? floorNumber;

  @HiveField(2)
  final int? buildingId;

  @HiveField(3)
  final String? floorCode;

  @HiveField(4)
  final double? mapScale;

  @HiveField(5)
  final double? rotationAngle;

  @HiveField(6)
  final String? imageUrl;

  factory FloorPlan.fromJson(Map<String, dynamic> json) =>
      _$FloorPlanFromJson(json);

  FloorPlan({
    this.id,
    this.floorNumber,
    this.buildingId,
    this.floorCode,
    this.mapScale,
    this.rotationAngle,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => _$FloorPlanToJson(this);
}
