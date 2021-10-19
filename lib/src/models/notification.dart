import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notifications {
  final int? id, accountId;
  final String? title, body, imageUrl, screen, parameter, status;
  final DateTime? date;
  Notifications({
    this.id,
    this.accountId,
    this.title,
    this.body,
    this.imageUrl,
    this.screen,
    this.parameter,
    this.status,
    this.date,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsToJson(this);
}
