import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';

abstract class Trilateration {
  Location2d solve(List<Location2d> locations);
}
