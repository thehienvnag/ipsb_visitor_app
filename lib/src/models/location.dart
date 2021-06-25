import 'package:flutter/material.dart';
import 'package:indoor_positioning_visitor/src/models/location_type.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int? id, locationTypeId, storeId, floorPlanId;
  final double? x, y;
  final LocationType? locationType;
  final Store? store;

  Location({
    this.id,
    this.locationTypeId,
    this.storeId,
    this.floorPlanId,
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
    return '{id=$id __ ($x, $y)}';
  }

  ImageProvider? retrieveStoreImg() {
    ImageProvider? image;
    var storeImg = this.store?.imageUrl;
    if (storeImg != null) {
      image = NetworkImage(storeImg);
    }
    return image;
  }
}
