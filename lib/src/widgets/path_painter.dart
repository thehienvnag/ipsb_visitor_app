import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class PathPainter extends CustomPainter {
  final List<Offset> points;
  final double space = 2;
  final double lineWidth = 3;
  PathPainter({
    required this.points,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    Path path = Path();
    path.addPolygon(points, false);

    canvas.drawPath(
      dashPath(path, dashArray: CircularIntervalList<double>(<double>[20, 13])),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
