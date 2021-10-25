import 'package:hive/hive.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';
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

  @HiveField(8)
  final Location? location;

  List<Product>? products;

  int? pos;

  @JsonKey(ignore: true)
  bool isExpanded;

  @JsonKey(ignore: true)
  bool complete;

  @JsonKey(ignore: true)
  double? distance;

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
    this.location,
    this.isExpanded = false,
    this.complete = false,
    this.distance,
  });

  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);

  Map<String, dynamic> toJson() => _$StoreToJson(this);

  void changeProductSelected(Product product) {
    this.products!.forEach((pro) {
      if (pro.id == product.id) {
        pro.checked = !pro.checked;
      }
    });
    if (this.products!.every((pro) => pro.checked)) {
      this.complete = true;
    } else {
      this.complete = false;
    }
  }
}
