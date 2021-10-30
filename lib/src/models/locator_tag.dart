import 'package:ipsb_visitor_app/src/models/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locator_tag.g.dart';

@JsonSerializable()
class LocatorTag {
  final int? id;
  final String? uuid;
  final double? txPower;
  final int? floorPlanId;
  final int? locatorTagGroupId;
  final int? locationId;
  final Location? location;
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
