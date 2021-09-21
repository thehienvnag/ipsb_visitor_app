import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/models/shopping_list.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shopping_item.g.dart';

@JsonSerializable()
class ShoppingItem {
  final int? id;
  final int? shoppingListId;
  final ShoppingList? shoppingList;
  final int? productId;
  final Product? product;
  final String? note;

  ShoppingItem({
    this.id,
    this.shoppingListId,
    this.shoppingList,
    this.productId,
    this.product,
    this.note,
  });

  factory ShoppingItem.fromJson(Map<String, dynamic> json) =>
      _$ShoppingItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingItemToJson(this);
}
