import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:path_drawing/path_drawing.dart';

class PathPainter extends CustomPainter {
  final List<Offset> points;
  final double space = 2;
  final double lineWidth = 3;
  final bool isActive;
  PathPainter({
    required this.points,
    this.isActive = true,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = this.isActive ? Colors.blue[200]! : Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 11
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.addPolygon(points, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
