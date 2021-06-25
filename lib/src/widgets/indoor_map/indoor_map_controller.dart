import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:indoor_positioning_visitor/src/models/location_type.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/widgets/current_location.dart';
import 'dart:ui' as ui;

import 'package:indoor_positioning_visitor/src/widgets/image_view/image_view_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/image_view/map_marker.dart';
import 'package:indoor_positioning_visitor/src/widgets/place_object.dart';
import 'package:indoor_positioning_visitor/src/widgets/marker_popup.dart';

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

  /// Set a point on map
  void setCurrentMarker(Location? location) {
    var marker = MapMarker(
      dx: 148,
      dy: 300,
      content: CurrentLocation(),
    );
    _imageViewController.setPoint(marker);
  }

  /// Set store list on map
  void loadLocationsOnMap(List<Location> locations) {
    final list = [
      MapMarker(
        dx: 91,
        dy: 696,
        content: PlaceObject(Location(
          locationTypeId: MarkerPopup.stairCase,
          x: 91,
          y: 696,
          locationType: LocationType(
            name: "Cầu thang",
            description: "Cầu thang bộ trong tòa nhà",
          ),
        )),
      ),
      MapMarker(
        dx: 579,
        dy: 1454,
        content: PlaceObject(Location(
          locationTypeId: MarkerPopup.stairCase,
          x: 579,
          y: 1454,
          locationType: LocationType(
            name: "Cầu thang",
            description: "Cầu thang bộ trong tòa nhà",
          ),
        )),
      ),
      MapMarker(
        dx: 661,
        dy: 837,
        content: PlaceObject(Location(
          locationTypeId: MarkerPopup.stairCase,
          x: 661,
          y: 837,
          locationType: LocationType(
            name: "Cầu thang",
            description: "Cầu thang bộ trong tòa nhà",
          ),
        )),
      ),
      MapMarker(
        dx: 661,
        dy: 937,
        content: PlaceObject(Location(
          locationTypeId: MarkerPopup.store,
          x: 661,
          y: 937,
          locationType: LocationType(
            name: "Cầu thang",
            description: "Cầu thang bộ trong tòa nhà",
          ),
          store: Store(
            name: 'ADIDAS',
            description: 'Cửa hàng giầy lớn nhất Việt Nam',
            imageUrl:
                'https://giayadidas.com.vn/wp-content/uploads/2018/11/bi%E1%BB%83u-t%C6%B0%E1%BB%A3ng-adidas_1-380x235.jpg',
          ),
        )),
      ),
      MapMarker(
        dx: 176,
        dy: 256,
        content: PlaceObject(Location(
          locationTypeId: MarkerPopup.elevator,
          x: 176,
          y: 256,
          locationType: LocationType(
            name: "Thang máy",
            description: "Thang máy trong tòa nhà",
          ),
        )),
      )
    ];
    _imageViewController.setMarkers(list);
  }

  /// Set path on map
  void setPathOnMap(List<Location> locations) {
    final list = [
      Offset(148, 330),
      Offset(148, 400),
      Offset(148, 500),
      Offset(148, 1440),
      Offset(500, 1440),
    ];
    _imageViewController.setPath(list);
  }
}
