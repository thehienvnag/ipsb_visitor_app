import 'dart:math';

import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/trilateration/trileration.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';

class SimpleTrilateration extends Trilateration {
  Location2d solve(List<Location2d> locations) {
    final p1 = locations[0];
    final p2 = locations[1];
    final p3 = locations[2];

    final A = 2 * p2.x - 2 * p1.x;
    final B = 2 * p2.y - 2 * p1.y;
    final C = pow(p1.distance!, 2) -
        pow(p2.distance!, 2) -
        pow(p1.x, 2) +
        pow(p2.x, 2) -
        pow(p1.y, 2) +
        pow(p2.y, 2);
    final D = 2 * p3.x - 2 * p2.x;
    final E = 2 * p3.y - 2 * p2.y;
    final F = pow(p2.distance!, 2) -
        pow(p3.distance!, 2) -
        pow(p2.x, 2) +
        pow(p3.x, 2) -
        pow(p2.y, 2) +
        pow(p3.y, 2);

    final x = (C * E - F * B) / (E * A - B * D);
    final y = (C * D - A * F) / (B * D - A * E);
    return Location2d(
      y: y,
      x: x,
      timeStamp: Utils.getCurrentTimeStamp(),
    );
  }
}
