import 'package:hive/hive.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
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

  final List<Product>? products;
  bool isExpanded;
  Store({
    this.products,
    this.floorPlan,
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.floorPlanId,
    this.productCategoryId,
    this.status,
    this.isExpanded = false,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
