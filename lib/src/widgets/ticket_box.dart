import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
import 'package:indoor_positioning_visitor/src/utils/utils.dart';

class TicketBox extends StatelessWidget {
  final double margin;
  final double borderRadius;
  final double clipRadius;
  final double smallClipRadius;
  final int numberOfSmallClips;
  final bool xAxisMain;
  final bool xAxisSeparator;
  final double fromEdgeMain;
  final double fromEdgeSeparator;
  final bool isOvalSeparator;
  final double ticketWidth;
  final double ticketHeight;
  final Widget child;
  final bool hasSeparator;
  const TicketBox({
    Key? key,
    this.margin = 20,
    this.borderRadius = 10,
    this.clipRadius = 18,
    this.smallClipRadius = 5,
    this.numberOfSmallClips = 13,
    this.xAxisMain = false,
    this.xAxisSeparator = true,
    required this.fromEdgeMain,
    required this.fromEdgeSeparator,
    this.isOvalSeparator = true,
    this.ticketWidth = 250,
    this.ticketHeight = 150,
    required this.child,
    this.hasSeparator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomClipper<Path> clipper = TicketClipper(
      xAxisMain: xAxisMain,
      fromEdgeMain: fromEdgeMain,
      borderRadius: borderRadius,
      clipRadius: clipRadius,
      smallClipRadius: smallClipRadius,
      numberOfSmallClips: numberOfSmallClips,
      xAxisSeparator: xAxisSeparator,
      fromEdgeSeparator: fromEdgeSeparator,
      isOvalSeparator: isOvalSeparator,
      ticketWidth: ticketWidth,
      ticketHeight: ticketHeight,
    );
    return Container(
      width: ticketWidth,
      height: ticketHeight,
      child: CustomPaint(
        painter: ClipShadowShadowPainter(
          shadow: Shadow(blurRadius: 2.5, color: Colors.grey.shade400),
          clipper: clipper,
        ),
        child: ClipPath(
          child: Container(
            child: CustomPaint(
              painter:
                  DashPainter(xAxisMain: xAxisMain, fromMain: fromEdgeMain),
              child: child,
            ),
            color: Colors.white,
          ),
          clipper: clipper,
        ),
      ),
    );
  }

  factory TicketBox.small({
    required String imgUrl,
    required String? storeName,
    required String? name,
    required String? description,
    required double? amount,
    required String? discountType,
    required DateTime? expireDate,
  }) {
    return TicketBox(
      margin: 20,
      xAxisMain: true,
      fromEdgeMain: 120,
      fromEdgeSeparator: 134,
      isOvalSeparator: false,
      smallClipRadius: 15,
      clipRadius: 10,
      numberOfSmallClips: 8,
      ticketWidth: 360,
      ticketHeight: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, left: 6),
            child: Card(
              child: Container(
                width: 95,
                height: 95,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
          Container(
            width: 227,
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      Formatter.shorten(storeName).toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      Formatter.amount(amount, discountType),
                      style: TextStyle(
                        fontSize: discountType == 'Fixed' ? 25 : 40,
                      ),
                    ),
                    Text(
                      Formatter.shorten(description, 20).toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 29),
                  child: Text(
                    'Hết hạn: ${Formatter.date(expireDate)}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashPainter extends CustomPainter {
  final double fromMain;
  final double ticketHeight;
  final double ticketWidth;
  final bool xAxisMain;
  DashPainter({
    this.fromMain = 120,
    this.ticketHeight = 130,
    this.ticketWidth = 360,
    this.xAxisMain = true,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint dashLine = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;
    Path path = Path();
    if (xAxisMain) {
      path.addPolygon([
        Offset(fromMain, xAxisMain ? 20 : 0),
        Offset(fromMain, ticketHeight - (xAxisMain ? 22 : 0))
      ], false);
      canvas.drawPath(
        dashPath(path,
            dashArray: CircularIntervalList<double>(<double>[14, 7])),
        dashLine,
      );
    } else {
      path.addPolygon(
          [Offset(35, fromMain), Offset(ticketWidth - 23, fromMain)], false);
      canvas.drawPath(
        dashPath(path,
            dashArray: CircularIntervalList<double>(<double>[20, 7])),
        dashLine,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  ClipShadowShadowPainter({
    required this.shadow,
    required this.clipper,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TicketClipper extends CustomClipper<Path> {
  static const double clipPadding = 0;
  final bool xAxisMain;
  final bool xAxisSeparator;
  final bool isOvalSeparator;
  final double fromEdgeMain;
  final double fromEdgeSeparator;
  final double borderRadius;
  final double clipRadius;
  final double smallClipRadius;
  final double ticketWidth;
  final double ticketHeight;
  final int numberOfSmallClips;

  const TicketClipper({
    required this.xAxisMain,
    required this.xAxisSeparator,
    required this.isOvalSeparator,
    required this.fromEdgeMain,
    required this.fromEdgeSeparator,
    required this.borderRadius,
    required this.clipRadius,
    required this.smallClipRadius,
    required this.ticketWidth,
    required this.ticketHeight,
    required this.numberOfSmallClips,
  });

  @override
  Path getClip(Size size) {
    var path = Path();

    final clipFromEdgeMain = fromEdgeMain;

    // draw rect
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, ticketWidth, ticketHeight),
      Radius.circular(borderRadius),
    ));

    final clipPath = Path();

    // circle on the left
    clipPath.addOval(Rect.fromCircle(
      center:
          xAxisMain ? Offset(clipFromEdgeMain, 0) : Offset(0, clipFromEdgeMain),
      radius: clipRadius,
    ));

    // circle on the right
    clipPath.addOval(Rect.fromCircle(
      center: xAxisMain
          ? Offset(clipFromEdgeMain, ticketHeight)
          : Offset(ticketWidth, clipFromEdgeMain),
      radius: clipRadius,
    ));

    // combine two path together
    final ticketPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      path,
    );

    return ticketPath;
  }

  @override
  bool shouldReclip(TicketClipper old) =>
      old.borderRadius != borderRadius ||
      old.clipRadius != clipRadius ||
      old.smallClipRadius != smallClipRadius ||
      old.numberOfSmallClips != numberOfSmallClips;
}
