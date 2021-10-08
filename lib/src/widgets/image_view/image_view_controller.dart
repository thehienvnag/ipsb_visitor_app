import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';

import 'package:ipsb_visitor_app/src/widgets/image_view/map_marker.dart';
import 'package:ipsb_visitor_app/src/widgets/marker_popup.dart';

import '../current_location.dart';
import '../shopping_point.dart';

class ImageViewController extends GetxController {
  /// Markers on the map
  final markers = <MapMarker>[].obs;

  /// Default point
  final point = MapMarker(
    dx: -100,
    dy: -100,
    content: CurrentLocation(),
  ).obs;

  /// Paths on the map
  final points = <Offset>[].obs;

  /// Service popup location on the map
  final servicePopup = PopupState(enabled: false).obs;

  /// Shopping point on the map
  final shoppingMarkers = <MapMarker>[].obs;

  void setShoppingMarkers(List<MapMarker> value) {
    shoppingMarkers.value = value;
  }

  void setPoint(MapMarker marker) {
    point.value = marker;
  }

  void setMarkers(List<MapMarker> value) {
    markers.value = value;
  }

  void setPath(List<Offset> value) {
    points.value = value;
  }

  var servicePopupEnabled = false.obs;

  void openPopup(Location location) {
    servicePopup.value = PopupState(
      location: location,
      locationR: Offset(location.x!, location.y!),
      popupType: PopupState.servicePopup,
      locationType: location.locationTypeId!,
    );
  }

  void closePopup(int type) {
    switch (type) {
      case PopupState.servicePopup:
        servicePopup.value = PopupState(enabled: false);
        break;
      default:
        break;
    }
  }

  void closeAllPopup() {
    servicePopup.value = PopupState(enabled: false);
  }
}

class PopupState {
  /// Service popup
  static const int servicePopup = 1;

  /// Store popup
  static const int storePopup = 2;

  final bool? enabled;
  final Offset locationR;
  double? width;
  double? height;
  final int popupType;
  final int locationType;
  final Offset offset = Offset(30, -10);
  final String? title;
  final String? description;
  final Location? location;
  PopupState({
    this.locationR = const Offset(0, 0),
    this.popupType = -1,
    this.locationType = -1,
    this.title = '',
    this.description = '',
    this.enabled = true,
    this.location,
  }) {
    this.width = determineWidth();
    this.height = determineHeight();
  }

  double determineWidth() {
    switch (location?.locationTypeId) {
      case MapKey.store:
        return MarkerPopup.storeWidth;
      case MapKey.stairCase:
      case MapKey.elevator:
      case MapKey.restRoom:
        return MarkerPopup.serviceWidth;
    }
    return 0;
  }

  double determineHeight() {
    switch (location?.locationTypeId) {
      case MapKey.store:
        return MarkerPopup.storeWidth;
      case MapKey.stairCase:
      case MapKey.elevator:
      case MapKey.restRoom:
        return MarkerPopup.serviceHeight;
    }
    return 0;
  }
}
