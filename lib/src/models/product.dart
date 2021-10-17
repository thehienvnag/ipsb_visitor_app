import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  bool? isSelected = false;
  final int? id;
  final String? name, description, imageUrl;
  final double? price;
  final Store? store;
  final String? status;
  final Product? productGroup;
  final List<Product>? inverseProductGroup;
  @JsonKey(ignore: true)
  int? shoppingItemId;
  @JsonKey(ignore: true)
  String? note;
  @JsonKey(ignore: true)
  bool checked = false;
  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.store,
    this.note,
    this.status,
    this.productGroup,
    this.inverseProductGroup,
  });
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
