import 'dart:ui';

import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/widgets/image_view/map_marker.dart';

class ImageViewController extends GetxController {
  /// Markers on the map
  final markers = <MapMarker>[].obs;

  void setMarkers(List<MapMarker> value) {
    markers.value = value;
  }

  /// Paths on the map
  final points = <Offset>[].obs;

  void setPath(List<Offset> value) {
    points.value = value;
  }
}
