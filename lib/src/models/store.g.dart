// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreAdapter extends TypeAdapter<Store> {
  @override
  final int typeId = 4;

  @override
  Store read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Store(
      floorPlan: fields[7] as FloorPlan?,
      id: fields[0] as int?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      imageUrl: fields[3] as String?,
      floorPlanId: fields[4] as int?,
      productCategoryId: fields[5] as String?,
      status: fields[6] as String?,
      location: fields[8] as Location?,
      building: fields[9] as Building?,
    );
  }

  @override
  void write(BinaryWriter writer, Store obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.floorPlanId)
      ..writeByte(5)
      ..write(obj.productCategoryId)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.floorPlan)
      ..writeByte(8)
      ..write(obj.location)
      ..writeByte(9)
      ..write(obj.building);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
    floorPlan: json['floorPlan'] == null
        ? null
        : FloorPlan.fromJson(json['floorPlan'] as Map<String, dynamic>),
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    imageUrl: json['imageUrl'] as String?,
    floorPlanId: json['floorPlanId'] as int?,
    productCategoryId: json['productCategoryId'] as String?,
    status: json['status'] as String?,
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
    building: json['building'] == null
        ? null
        : Building.fromJson(json['building'] as Map<String, dynamic>),
  )..pos = json['pos'] as int?;
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'floorPlanId': instance.floorPlanId,
      'productCategoryId': instance.productCategoryId,
      'status': instance.status,
      'floorPlan': instance.floorPlan,
      'location': instance.location,
      'building': instance.building,
      'products': instance.products,
      'pos': instance.pos,
    };
