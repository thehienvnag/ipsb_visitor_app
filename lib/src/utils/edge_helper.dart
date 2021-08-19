import 'dart:ui';

import 'package:indoor_positioning_visitor/src/models/edge.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';

const double cmToMeter = 3.5;
const double meterToPixel = 10.8;
const double minDistance = 3;
const List<int> stairAndLift = [3, 4];

class EdgeHelper {
  static List<Edge> splitToSegments(List<Edge> edges) {
    if (edges.isEmpty) return [];
    List<Edge> result = [];
    int id = getMaxLocationId(edges);
    edges.forEach((edge) {
      final segments = getSegments(edge, minDistance, id);
      if (segments.isNotEmpty) {
        result.addAll(segments);
        id += segments.length;
      } else {
        result.add(edge);
      }
    });
    return result;
  }

  static List<Location> testPaths(List<Edge> edges) {
    Map<int, Location> locs = {};
    edges.forEach((e) {
      locs.putIfAbsent(e.fromLocationId!, () => e.fromLocation!);
      locs.putIfAbsent(e.toLocationId!, () => e.toLocation!);
    });
    return locs.values.toList();
  }

  static int getMaxLocationId(List<Edge> edges) {
    int id = 0;
    edges.forEach((edge) {
      if (edge.fromLocationId! > id) id = edge.fromLocationId!;
      if (edge.toLocationId! > id) id = edge.toLocationId!;
    });
    return id;
  }

  static bool isFloorConnect(Edge edge) =>
      stairAndLift.contains(edge.fromLocation?.locationTypeId) &&
      stairAndLift.contains(edge.toLocation?.locationTypeId);

  static List<Edge> getSegments(Edge edge, double minDistance, int id) {
    double segment = minDistance * meterToPixel;
    int divide = (edge.distance! / segment).round();
    if (isFloorConnect(edge) || divide < 2) return [];

    int part = 1;
    List<Location> locations = [];
    locations.add(edge.fromLocation!);
    while (part < divide) {
      // Point 1 - (x1, y1)
      double x1 = edge.fromLocation?.x as double;
      double y1 = edge.fromLocation?.y as double;
      // Point 2 - (x2, y2)
      double x2 = edge.toLocation?.x as double;
      double y2 = edge.toLocation?.y as double;
      // Point calculated (x, y)
      double x = x1 + (part / divide) * (x2 - x1);
      double y = y1 + (part / divide) * (y2 - y1);

      // Location id
      int locId = ++id;

      // Locations
      locations.add(Location(
        id: locId,
        x: x,
        y: y,
        locationTypeId: 2,
        floorPlanId: edge.fromLocation?.floorPlanId,
      ));
      part++;
    }
    locations.add(edge.toLocation!);

    List<Edge> result = [];
    double distance = edge.distance! / divide;
    int i = 0;
    while (i < locations.length - 1) {
      final from = locations[i];
      final to = locations[i + 1];
      result.add(Edge(
        fromLocationId: from.id,
        fromLocation: from,
        toLocationId: to.id,
        toLocation: to,
        distance: distance,
      ));
      i++;
    }
    return result;
  }
}
