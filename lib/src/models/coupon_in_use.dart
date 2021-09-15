import 'package:com.ipsb.visitor_app/src/models/coupon.dart';

import 'package:json_annotation/json_annotation.dart';

import 'account.dart';

part 'coupon_in_use.g.dart';

@JsonSerializable()
class CouponInUse {
  final int? id;
  final int? couponId, visitorId;
  final DateTime? redeemDate, applyDate, feedBackDate;
  final String? status, feedbackContent, feedbackImage;
  final double? rateScore;
  Coupon? coupon;
  Account? visitor;

  CouponInUse(
      {this.applyDate,
      this.couponId,
      this.id,
      this.visitorId,
      this.redeemDate,
      this.status,
      this.feedbackContent,
      this.feedbackImage,
      this.feedBackDate,
      this.rateScore,
      this.coupon,
      this.visitor});

  factory CouponInUse.fromJson(Map<String, dynamic> json) =>
      _$CouponInUseFromJson(json);

  Map<String, dynamic> toJson() => _$CouponInUseToJson(this);
}
