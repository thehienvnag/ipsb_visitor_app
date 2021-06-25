import 'package:indoor_positioning_visitor/src/models/floor_plan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

@JsonSerializable()
class Store {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? floorPlanId;
  final String? status;
  final FloorPlan? floorPlan;

  Store({
    this.floorPlan,
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.floorPlanId,
    this.status,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
