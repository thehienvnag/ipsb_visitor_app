// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon(
    id: json['id'] as int?,
    name: json['name'] as String?,
    imageUrl: json['imageUrl'] as String?,
    description: json['description'] as String?,
    code: json['code'] as String?,
    discountType: json['discountType'] as String?,
    expireDate: json['expireDate'] as String?,
    publishDate: json['publishDate'] as String?,
    productInclude: json['productInclude'] as String?,
    productExclude: json['productExclude'] as String?,
    status: json['status'] as String?,
    amount: (json['amount'] as num?)?.toDouble(),
    maxDiscount: (json['maxDiscount'] as num?)?.toDouble(),
    minDiscount: (json['minDiscount'] as num?)?.toDouble(),
    limit: json['limit'] as int?,
    storeId: (json['storeId'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'code': instance.code,
      'discountType': instance.discountType,
      'expireDate': instance.expireDate,
      'publishDate': instance.publishDate,
      'productInclude': instance.productInclude,
      'productExclude': instance.productExclude,
      'status': instance.status,
      'amount': instance.amount,
      'maxDiscount': instance.maxDiscount,
      'minDiscount': instance.minDiscount,
      'storeId': instance.storeId,
      'limit': instance.limit,
    };
