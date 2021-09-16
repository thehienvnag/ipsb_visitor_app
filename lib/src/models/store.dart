import 'package:hive/hive.dart';
import 'package:visitor_app/src/common/constants.dart';
import 'package:visitor_app/src/models/floor_plan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

@JsonSerializable()
@HiveType(typeId: AppHiveType.store)
class Store {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final String? imageUrl;

  @HiveField(4)
  final int? floorPlanId;

  @HiveField(5)
  final String? productCategoryId;

  @HiveField(6)
  final String? status;

  @HiveField(7)
  final FloorPlan? floorPlan;

  Store({
    this.floorPlan,
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.floorPlanId,
    this.productCategoryId,
    this.status,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
