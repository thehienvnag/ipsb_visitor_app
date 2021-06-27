import 'dart:math';

import 'package:flutter/material.dart';
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
    return Container(
      width: ticketWidth,
      height: ticketHeight,
      child: ClipPath(
        clipper: TicketClipper(
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
          hasSeparator: hasSeparator,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: child,
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
      fromEdgeMain: 62,
      fromEdgeSeparator: 134,
      isOvalSeparator: false,
      smallClipRadius: 15,
      clipRadius: 29,
      numberOfSmallClips: 8,
      ticketWidth: 360,
      ticketHeight: 130,
      child: Container(
        color: Colors.grey.withOpacity(.2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Utils.resolveImg(
              imgUrl,
              fit: BoxFit.fitHeight,
              width: 125,
            ),
            // Image.network(
            //   // 'https://channel.mediacdn.vn/thumb_w/640/prupload/164/2017/05/img20170523165323853.jpg',
            //   imgUrl,
            //   fit: BoxFit.fitHeight,
            //   width: 125,
            // ),
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
                    margin: const EdgeInsets.only(bottom: 47),
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
      ),
    );
  }
}

class BorderPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;
    paint.color = Colors.white;

    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      pi,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TicketClipper extends CustomClipper<Path> {
  static const double clipPadding = 0;
  final bool xAxisMain;
  final bool xAxisSeparator;
  final bool isOvalSeparator;
  final bool hasSeparator;
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
    required this.hasSeparator,
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
    final clipFromEdgeSeparator = fromEdgeSeparator;

    // draw rect
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, ticketWidth, ticketHeight),
      Radius.circular(borderRadius),
    ));

    final clipPath = Path();

    // circle on the left
    clipPath.addOval(Rect.fromCircle(
      center: xAxisMain
          ? Offset(clipFromEdgeMain, -8)
          : Offset(-8, clipFromEdgeMain),
      radius: clipRadius,
    ));

    // circle on the right
    clipPath.addOval(Rect.fromCircle(
      center: xAxisMain
          ? Offset(clipFromEdgeMain, ticketHeight + 8)
          : Offset(ticketWidth + 8, clipFromEdgeMain),
      radius: clipRadius,
    ));
    if (hasSeparator) {
      final clipContainerSize = (xAxisMain ? ticketHeight : ticketWidth) -
          clipRadius * 2 -
          clipPadding * 2;
      final smallClipSize = smallClipRadius * 2;
      final smallClipBoxSize = clipContainerSize / numberOfSmallClips;
      final smallClipPadding = (smallClipBoxSize - smallClipSize) / 2;
      final smallClipStart = 0;

      final smallClipCenterOffsets = List.generate(numberOfSmallClips, (index) {
        final boxX = smallClipStart + smallClipBoxSize * index;
        final centerX = boxX + smallClipPadding + smallClipRadius;

        return xAxisSeparator
            ? Offset(clipFromEdgeSeparator, centerX)
            : Offset(centerX, clipFromEdgeSeparator);
      });

      smallClipCenterOffsets.forEach((centerOffset) {
        if (isOvalSeparator) {
          clipPath.addOval(Rect.fromCircle(
            center: centerOffset,
            radius: smallClipRadius,
          ));
        } else {
          clipPath.addRect(
            Rect.fromCenter(
              center: centerOffset,
              width: 2,
              height: smallClipRadius,
            ),
          );
        }
      });
    }

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
