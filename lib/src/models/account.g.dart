// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    id: json['id'] as int?,
    name: json['name'] as String?,
    role: json['role'] as String?,
    imageUrl: json['imageUrl'] as String?,
    phone: json['phone'] as String?,
    email: json['email'] as String?,
    status: json['status'] as String?,
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'imageUrl': instance.imageUrl,
      'phone': instance.phone,
      'email': instance.email,
      'status': instance.status,
    };
