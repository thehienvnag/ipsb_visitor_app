import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:indoor_positioning_visitor/src/widgets/current_location.dart';
import 'dart:ui' as ui;

import 'package:indoor_positioning_visitor/src/widgets/image_view/image_view_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/image_view/map_marker.dart';
import 'package:indoor_positioning_visitor/src/widgets/place_object.dart';

class IndoorMapController extends GetxController {
  final TransformationController transformationController =
      TransformationController();

  /// Controller for image view
  ImageViewController _imageViewController = Get.find();

  /// move to scene
  void moveToScene(Location? location) {
    if (location == null) return;
    transformationController.value = Matrix4.identity()
      ..translate(location.x!, location.y!);
  }

  /// Get image size from image provider
  Future<ui.Image> getImage(ImageProvider imageProvider) {
    Completer<ui.Image> completer = Completer<ui.Image>();
    imageProvider
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener(
          (ImageInfo info, bool _) => completer.complete(info.image),
        ));
    return completer.future;
  }

  /// Set a point on map
  void setCurrentMarker(Location? location) {
    var marker;
    if (location == null) {
      marker = MapMarker(dx: -100, dy: -100, content: CurrentLocation());
    } else {
      marker = MapMarker(
        dx: location.x!,
        dy: location.y!,
        content: CurrentLocation(),
      );
    }
    _imageViewController.setPoint(marker);
  }

  /// Set store list on map
  void loadLocationsOnMap(List<Location> locations) {
    final list = locations
        .where((element) => element.locationTypeId != 2)
        .map((e) => MapMarker(
              dx: e.x!,
              dy: e.y!,
              content: PlaceObject(e),
            ))
        .toList();

    _imageViewController.setMarkers(list);
  }

  /// Set path on map
  void setPathOnMap(List<Location> locations) {
    final list = locations.map((e) => Offset(e.x!, e.y!)).toList();
    _imageViewController.setPath(list);
  }
}
