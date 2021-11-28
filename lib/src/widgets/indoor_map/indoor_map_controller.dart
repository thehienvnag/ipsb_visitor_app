import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/widgets/current_location.dart';
import 'dart:ui' as ui;

import 'package:ipsb_visitor_app/src/widgets/image_view/image_view_controller.dart';
import 'package:ipsb_visitor_app/src/widgets/image_view/map_marker.dart';
import 'package:ipsb_visitor_app/src/widgets/place_object.dart';

import '../shopping_point.dart';

class IndoorMapController extends GetxController {
  final transformationController = TransformationController();

  /// Controller for image view
  ImageViewController _imageViewController = Get.find();

  /// Screen size
  final screenSize = Size(0, 0).obs;

  /// Rotate angle
  final rotateAngle = 0.0.obs;

  /// move to scene
  void moveToScene(Location? location) {
    if (location == null) return;
    Offset toScene = transformationController.toScene(
      Offset(-location.x!, -location.y!),
    );
    // print("dx: ${toScene.dx + 150}, dy: ${toScene.dy + 150}");
    transformationController.value.translate(
      toScene.dx + screenSize.value.width / 2,
      toScene.dy + screenSize.value.height / 2 - 100,
    );
  }

  /// Rotate camera
  void rotateCamera(double rotate) {
    if ((rotate - rotateAngle.value).abs() > 2) {
      rotateAngle.value = rotate * pi / 180;
    }
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

  /// Set active routes on map
  void setActiveRoute(List<Location> locations) {
    final list = locations.map((e) => Offset(e.x!, e.y!)).toList();
    _imageViewController.setActivePath(list);
  }

  /// Set inactive routes on map
  void setInActiveRoute(List<Location> locations) {
    final list = locations.map((e) => Offset(e.x!, e.y!)).toList();
    _imageViewController.setInActivePath(list);
  }

  /// Set Shopping points on map
  void setShoppingPoints(List<Store> stores) {
    final listMarkers = stores.map((store) {
      final location = store.location!;
      return MapMarker(
        dx: location.x!,
        dy: location.y!,
        content: ShoppingPoint(
          store: store,
          index: (store.pos).toString(),
        ),
      );
    }).toList();
    _imageViewController.setShoppingMarkers(listMarkers);
  }
}
