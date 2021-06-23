import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      child: CustomPaint(
        painter: GlowingCircle(10),
      ),
    );
  }
}

class GlowingCircle extends CustomPainter {
  final innerCircle = Paint()
    ..color = Color(0XFF4086F4)
    ..style = PaintingStyle.fill;

  final border = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  final outerCircle = Paint()
    ..color = Color(0XFF4086F4).withOpacity(0.08)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 14.0;

  final double radius;

  GlowingCircle(this.radius);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
      Rect.fromCircle(center: Offset(0, 0), radius: radius),
      innerCircle,
    );
    canvas.drawOval(
      Rect.fromCircle(center: Offset(0, 0), radius: radius + 3),
      border,
    );
    canvas.drawOval(
      Rect.fromCircle(center: Offset(0, 0), radius: radius + 10),
      outerCircle,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
