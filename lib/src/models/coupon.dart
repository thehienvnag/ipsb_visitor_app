class Coupon {
  final int id;
  final String? name, imageUrl, description, code, discountType, expireDate, publishDate, productInclude, productExclude, status;
  final double? amount;
  final int? maxDiscount, minDiscount, limit, storeId;

  Coupon({
    required this.id, this.name, this.imageUrl, this.description, this.code,
    this.discountType, this.expireDate, this.publishDate, this.productInclude,
    this.productExclude, this.status, this.amount, this.maxDiscount, this.minDiscount,
    this.limit, this.storeId
  });

}