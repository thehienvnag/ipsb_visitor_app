import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  bool? isSelected = false;
  final int? id;
  final String? name, description, imageUrl;
  final double? price;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
  });
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
