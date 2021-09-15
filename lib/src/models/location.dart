import 'package:flutter/material.dart';
import 'location_type.dart';
import 'store.dart';
import 'floor_plan.dart';
import 'package:hive/hive.dart';
import 'package:com.ipsb.visitor_app/src/common/constants.dart';

import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
@HiveType(typeId: AppHiveType.location)
class Location {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final int? locationTypeId;

  @HiveField(2)
  final int? storeId;

  @HiveField(3)
  final int? floorPlanId;

  @HiveField(4)
  final double? x;

  @HiveField(5)
  final double? y;

  @HiveField(6)
  final LocationType? locationType;

  @HiveField(7)
  final Store? store;

  @HiveField(8)
  final FloorPlan? floorPlan;

  Location({
    this.id,
    this.locationTypeId,
    this.storeId,
    this.floorPlanId,
    this.floorPlan,
    this.x,
    this.y,
    this.locationType,
    this.store,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString() {
    return '{id: $id, x: $x, y: $y, floorPlanId: $floorPlanId}\n';
  }

  ImageProvider retrieveStoreImg() {
    ImageProvider? image;
    var storeImg = this.store?.imageUrl;
    if (storeImg != null) {
      image = NetworkImage(storeImg);
    } else {
      image = AssetImage(Constants.imageErr);
    }
    return image;
  }
}
