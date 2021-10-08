// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingList _$ShoppingListFromJson(Map<String, dynamic> json) {
  return ShoppingList(
    accountId: json['accountId'] as int?,
    account: json['account'] == null
        ? null
        : Account.fromJson(json['account'] as Map<String, dynamic>),
    id: json['id'] as int?,
    buildingId: json['buildingId'] as int?,
    name: json['name'] as String?,
    shoppingDate: json['shoppingDate'] == null
        ? null
        : DateTime.parse(json['shoppingDate'] as String),
    status: json['status'] as String?,
    building: json['building'] == null
        ? null
        : Building.fromJson(json['building'] as Map<String, dynamic>),
    shoppingItems: (json['shoppingItems'] as List<dynamic>?)
        ?.map((e) => ShoppingItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ShoppingListToJson(ShoppingList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buildingId': instance.buildingId,
      'building': instance.building,
      'accountId': instance.accountId,
      'account': instance.account,
      'name': instance.name,
      'shoppingDate': instance.shoppingDate?.toIso8601String(),
      'status': instance.status,
      'shoppingItems': instance.shoppingItems,
    };
