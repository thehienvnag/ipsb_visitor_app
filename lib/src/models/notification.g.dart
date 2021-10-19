// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notifications _$NotificationsFromJson(Map<String, dynamic> json) {
  return Notifications(
    id: json['id'] as int?,
    accountId: json['accountId'] as int?,
    title: json['title'] as String?,
    body: json['body'] as String?,
    imageUrl: json['imageUrl'] as String?,
    screen: json['screen'] as String?,
    parameter: json['parameter'] as String?,
    status: json['status'] as String?,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'title': instance.title,
      'body': instance.body,
      'imageUrl': instance.imageUrl,
      'screen': instance.screen,
      'parameter': instance.parameter,
      'status': instance.status,
      'date': instance.date?.toIso8601String(),
    };
