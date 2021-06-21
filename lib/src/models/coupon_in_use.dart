import 'package:indoor_positioning_visitor/src/models/coupon.dart';

import 'package:json_annotation/json_annotation.dart';

part 'coupon_in_use.g.dart';

@JsonSerializable()
class CouponInUse {
  final int? id;
  final int? couponId, visitorId;
  final DateTime? redeemDate, applyDate;
  final String? status;
  final Coupon? coupon;

  CouponInUse({
    this.applyDate,
    this.couponId,
    this.id,
    this.visitorId,
    this.redeemDate,
    this.status,
    this.coupon,
  });

  factory CouponInUse.fromJson(Map<String, dynamic> json) =>
      _$CouponInUseFromJson(json);

  Map<String, dynamic> toJson() => _$CouponInUseToJson(this);
}
