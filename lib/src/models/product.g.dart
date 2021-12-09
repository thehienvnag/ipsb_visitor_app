// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int?,
    storeId: json['storeId'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    price: (json['price'] as num?)?.toDouble(),
    imageUrl: json['imageUrl'] as String?,
    store: json['store'] == null
        ? null
        : Store.fromJson(json['store'] as Map<String, dynamic>),
    status: json['status'] as String?,
  )..isSelected = json['isSelected'] as bool?;
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'isSelected': instance.isSelected,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'store': instance.store,
      'storeId': instance.storeId,
      'status': instance.status,
    };
