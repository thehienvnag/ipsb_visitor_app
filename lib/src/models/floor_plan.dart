import 'package:hive/hive.dart';
import 'package:visitor_app/src/common/constants.dart';
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
  final String? floorNum;

  @HiveField(5)
  final String? imageUrl;

  FloorPlan({
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
