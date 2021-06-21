class CouponInUse {
  final int id;
  final int? couponId, visitorId;
  final String? redeemDate, applyDate, name, imageUrl, description, code, discountType, expireDate, publishDate, productInclude, productExclude, status;

  CouponInUse({
    this.name, this.imageUrl, this.description, this.code, this.discountType, this.expireDate,
    this.publishDate, this.productInclude, this.productExclude, this.couponId,
    required this.id,  this.visitorId, this.redeemDate, this.applyDate, this.status
  });
}