import 'dart:math';
import 'dart:ui';

class Utils {
  static double calDistance(Offset p1, Offset p2) {
    var xSquare = pow(p2.dx - p1.dx, 2);
    var ySquare = pow(p2.dy - p1.dy, 2);
    return sqrt(xSquare + ySquare);
  }
}
