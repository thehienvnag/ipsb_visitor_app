import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon {
  final int? id;
  final String? name,
      imageUrl,
      description,
      code,
      discountType,
      productInclude,
      productExclude,
      status;
  final double? amount, maxDiscount, minDiscount, storeId;
  final int? limit;
  final DateTime? expireDate, publishDate;
  final Store? store;

  Coupon({
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.code,
    this.discountType,
    this.expireDate,
    this.publishDate,
    this.productInclude,
    this.productExclude,
    this.status,
    this.amount,
    this.maxDiscount,
    this.minDiscount,
    this.limit,
    this.storeId,
    this.store,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
