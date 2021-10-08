// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_in_use.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponInUse _$CouponInUseFromJson(Map<String, dynamic> json) {
  return CouponInUse(
    applyDate: json['applyDate'] == null
        ? null
        : DateTime.parse(json['applyDate'] as String),
    couponId: json['couponId'] as int?,
    id: json['id'] as int?,
    visitorId: json['visitorId'] as int?,
    redeemDate: json['redeemDate'] == null
        ? null
        : DateTime.parse(json['redeemDate'] as String),
    status: json['status'] as String?,
    feedbackContent: json['feedbackContent'] as String?,
    feedbackImage: json['feedbackImage'] as String?,
    feedBackDate: json['feedBackDate'] == null
        ? null
        : DateTime.parse(json['feedBackDate'] as String),
    rateScore: (json['rateScore'] as num?)?.toDouble(),
    coupon: json['coupon'] == null
        ? null
        : Coupon.fromJson(json['coupon'] as Map<String, dynamic>),
    visitor: json['visitor'] == null
        ? null
        : Account.fromJson(json['visitor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CouponInUseToJson(CouponInUse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'couponId': instance.couponId,
      'visitorId': instance.visitorId,
      'redeemDate': instance.redeemDate?.toIso8601String(),
      'applyDate': instance.applyDate?.toIso8601String(),
      'feedBackDate': instance.feedBackDate?.toIso8601String(),
      'status': instance.status,
      'feedbackContent': instance.feedbackContent,
      'feedbackImage': instance.feedbackImage,
      'rateScore': instance.rateScore,
      'coupon': instance.coupon,
      'visitor': instance.visitor,
    };
