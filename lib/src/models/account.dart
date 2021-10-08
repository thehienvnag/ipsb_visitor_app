import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  final int? id;
  final String? name,
      role,
      imageUrl,
      phone,
      email,
      accessToken,
      refreshToken,
      status;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Account({
    this.accessToken,
    this.refreshToken,
    this.id,
    this.name,
    this.role,
    this.imageUrl,
    this.phone,
    this.email,
    this.status,
  });

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
