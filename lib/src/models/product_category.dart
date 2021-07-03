import 'package:json_annotation/json_annotation.dart';

part 'product_category.g.dart';

@JsonSerializable()
class ProductCategory {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  ProductCategory({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);

  @override
  String toString() {
    return '$id-$name';
  }
}
