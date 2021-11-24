import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'locator_tag.g.dart';

@JsonSerializable()
@HiveType(typeId: AppHiveType.locatorTag)
class LocatorTag {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? uuid;
  @HiveField(2)
  final double? txPower;
  @HiveField(3)
  final int? floorPlanId;
  @HiveField(4)
  final int? locatorTagGroupId;
  @HiveField(5)
  final int? locationId;
  @HiveField(6)
  final Location? location;
  @HiveField(7)
  final String? status;

  factory LocatorTag.fromJson(Map<String, dynamic> json) =>
      _$LocatorTagFromJson(json);

  LocatorTag({
    this.id,
    this.uuid,
    this.txPower,
    this.floorPlanId,
    this.locatorTagGroupId,
    this.locationId,
    this.location,
    this.status,
  });

  Map<String, dynamic> toJson() => _$LocatorTagToJson(this);
}
