import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon {
  final int? id;
  final String? name,
      imageUrl,
      description,
      code,
      productInclude,
      productExclude,
      status;
  final bool? overLimit;

  final double? amount, maxDiscount, minSpend;
  final int? storeId, couponTypeId, limit;
  final DateTime? expireDate, publishDate;
  final Store? store;

  Coupon({
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.code,
    this.expireDate,
    this.publishDate,
    this.productInclude,
    this.productExclude,
    this.status,
    this.amount,
    this.overLimit,
    this.maxDiscount,
    this.minSpend,
    this.limit,
    this.storeId,
    this.couponTypeId,
    this.store,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
