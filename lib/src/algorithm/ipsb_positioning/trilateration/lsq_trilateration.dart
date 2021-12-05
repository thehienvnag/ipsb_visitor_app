import 'dart:math';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/trilateration/trileration.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';
import 'package:linalg/linalg.dart';

class LSQTrilateration extends Trilateration {
  @override
  Location2d solve(List<Location2d> locations) {
    if (locations.length < 3 || locations.any((e) => e.distance == null))
      throw ArgumentError();
    // Last location
    final last = locations.last;
    // List of locations without the last location
    final locationsForCalculation = locations.getRange(0, locations.length - 1);

    // Formation of matrix A for equation: Ax = b
    final matrixA = _formMatrixA(locationsForCalculation, last);
    final vectorB = _formVectorB(locationsForCalculation, last);

    final transposeA = matrixA.transpose();

    final x = (transposeA * matrixA).inverse() * (transposeA * vectorB);

    final xVector = x.toVector();
    return Location2d(
      x: xVector[0],
      y: xVector[1],
      timeStamp: Utils.getCurrentTimeStamp(),
      floorPlanId: last.floorPlanId,
    );
  }

  /// Form matrix A for trilateration calculation
  ///
  /// Provide the list of locations [locations] and the last location [last]
  Matrix _formMatrixA(Iterable<Location2d> locations, Location2d last) {
    return Matrix(
      locations
          .map((e) => [
                2 * (e.x - last.x),
                2 * (e.y - last.y),
              ])
          .toList(),
    );
  }

  /// Form matrix A for trilateration calculation
  ///
  /// Provide the list of locations [locations] and the last location
  Vector _formVectorB(Iterable<Location2d> locations, Location2d last) {
    return Vector.column(
      locations
          .map(
            (e) => (pow(e.x, 2) -
                    pow(last.x, 2) +
                    pow(e.y, 2) -
                    pow(last.y, 2) +
                    pow(last.distance!, 2) -
                    pow(e.distance!, 2))
                .toDouble(),
          )
          .toList(),
    );
  }
}
