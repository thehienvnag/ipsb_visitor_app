import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:indoor_positioning_visitor/src/widgets/current_location.dart';
import 'dart:ui' as ui;

import 'package:indoor_positioning_visitor/src/widgets/image_view/image_view_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/image_view/map_marker.dart';

class IndoorMapController extends GetxController {
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

  /// Controller for image view
  ImageViewController _imageViewController = Get.find();

  /// Set store list on map
  void loadStoresOnMap(List<Location> locations) {
    final list = [
      MapMarker(
        dx: 148,
        dy: 230,
        content: CurrentLocation(),
      )
    ];
    _imageViewController.setMarkers(list);
  }

  /// Set path on map
  void setPathOnMap(List<Location> locations) {
    final list = [
      Offset(148, 250),
      Offset(148, 400),
      Offset(148, 500),
      Offset(148, 1440),
      Offset(500, 1440),
    ];
    _imageViewController.setPath(list);
  }
}
