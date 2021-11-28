import 'package:ipsb_visitor_app/src/models/edge.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';

import 'utils.dart';

const List<int> stairAndLift = [3, 4];

class EdgeHelperResponse {
  late List<Edge> edges;
  Location? projection;
}

class EdgeHelper {
  static List<Edge> splitToSegments(List<Edge> edges, double mapScale) {
    if (edges.isEmpty) return [];
    List<Edge> result = [];
    int id = getMaxLocationId(edges);
    edges.forEach((edge) {
      final segments = getSegments(edge, id, mapScale);
      if (segments.isNotEmpty) {
        result.addAll(segments);
        id += segments.length;
      } else {
        result.add(edge);
      }
    });
    return result;
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

  static List<Edge> getSegments(
    Edge edge,
    int id,
    double mapScale,
  ) {
    const minDistance = 0.7; // Meter
    const meterToPixel = 3779.5275590551; // Meter to pixel
    double segment = minDistance / mapScale * meterToPixel;

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

  static Location findNearestLocation(List<Edge> edges, Location loc) {
    if (edges.isEmpty) return loc;
    Location location = edges[0].fromLocation!;
    double minDistance = Utils.calDistance(
      location,
      loc,
    );
    edges.forEach((e) {
      double fromDistance = Utils.calDistance(
        loc,
        e.fromLocation!,
      );
      if (fromDistance < minDistance) {
        minDistance = fromDistance;
        location = e.fromLocation!;
      }

      double toDistance = Utils.calDistance(
        loc,
        e.toLocation!,
      );
      if (toDistance < minDistance) {
        minDistance = toDistance;
        location = e.toLocation!;
      }
    });
    return location;
  }

  static EdgeHelperResponse edgesWithCurrentLocation(
    List<Edge> edges,
    Location current,
  ) {
    Iterable<Edge>? edgesToProject;
    List<int>? edgeIdsToRemoved;
    double? minDistance;
    Location? projection;
    EdgeHelperResponse response = EdgeHelperResponse();
    if (current.x == null || current.y == null) {
      response.edges = edges;
      return response;
    }

    edges.forEach((e) {
      if (e.fromLocation?.floorPlanId == current.floorPlanId &&
          e.toLocation?.floorPlanId == current.floorPlanId) {
        double A = current.x! - e.fromLocation!.x!;
        double B = current.y! - e.fromLocation!.y!;
        double C = e.toLocation!.x! - e.fromLocation!.x!;
        double D = e.toLocation!.y! - e.fromLocation!.y!;

        double dot = A * C + B * D;
        double lengthSquared = C * C + D * D;
        double param = -1;
        if (lengthSquared != 0) {
          //in case of 0 length line
          param = dot / lengthSquared;
        }

        if (param < 0) {
          final distance = Utils.calDistance(e.fromLocation!, current);
          if (minDistance == null || distance < minDistance!) {
            minDistance = distance;
            projection = e.fromLocation!;
            edgesToProject = [
              Edge(
                fromLocationId: e.fromLocationId,
                fromLocation: e.fromLocation,
                toLocationId: current.id,
                toLocation: current,
                distance: distance,
              )
            ];
          }
        } else if (param > 1) {
          final distance = Utils.calDistance(e.toLocation!, current);
          if (minDistance == null || distance < minDistance!) {
            minDistance = distance;
            projection = e.fromLocation!;
            edgesToProject = [
              Edge(
                fromLocationId: e.toLocationId,
                fromLocation: e.toLocation,
                toLocationId: current.id,
                toLocation: current,
                distance: distance,
              )
            ];
          }
        } else {
          projection = Location(
            id: -2,
            x: e.fromLocation!.x! + param * C,
            y: e.fromLocation!.y! + param * D,
            locationTypeId: 2,
            floorPlanId: current.floorPlanId,
          );
          final distance = Utils.calDistance(projection!, current);
          if (minDistance == null || distance < minDistance!) {
            minDistance = distance;
            edgesToProject = [
              Edge(
                fromLocationId: current.id,
                fromLocation: current,
                toLocationId: projection!.id,
                toLocation: projection,
                distance: distance,
              ),
              Edge(
                toLocationId: e.toLocationId,
                toLocation: e.toLocation,
                fromLocationId: projection!.id,
                fromLocation: projection,
                distance: Utils.calDistance(projection!, e.toLocation!),
              ),
              Edge(
                toLocationId: e.fromLocationId,
                toLocation: e.fromLocation,
                fromLocationId: projection!.id,
                fromLocation: projection,
                distance: Utils.calDistance(projection!, e.fromLocation!),
              ),
            ];
            edgeIdsToRemoved = [e.id ?? -1];
          }
        }
      }
    });

    if (edgesToProject != null) {
      edges.addAll(edgesToProject!);
      response.edges = edges
          .where((e) => !(edgeIdsToRemoved?.contains(e.id) ?? false))
          .toList();
      response.projection = projection;
    }

    return response;
  }
}
