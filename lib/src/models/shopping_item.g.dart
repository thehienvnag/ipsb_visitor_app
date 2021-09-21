// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingItem _$ShoppingItemFromJson(Map<String, dynamic> json) {
  return ShoppingItem(
    id: json['id'] as int?,
    shoppingListId: json['shoppingListId'] as int?,
    shoppingList: json['shoppingList'] == null
        ? null
        : ShoppingList.fromJson(json['shoppingList'] as Map<String, dynamic>),
    productId: json['productId'] as int?,
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    note: json['note'] as String?,
  );
}

Map<String, dynamic> _$ShoppingItemToJson(ShoppingItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shoppingListId': instance.shoppingListId,
      'shoppingList': instance.shoppingList,
      'productId': instance.productId,
      'product': instance.product,
      'note': instance.note,
    };
