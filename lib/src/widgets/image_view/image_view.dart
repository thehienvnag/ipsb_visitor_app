import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/widgets/image_view/image_view_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/image_view/map_marker.dart';
import 'package:indoor_positioning_visitor/src/widgets/path_painter.dart';

class ImageView extends GetView<ImageViewController> {
  final double width, height;
  final ImageProvider image;
  const ImageView({
    required this.height,
    required this.width,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(image: image),
      ),
      child: Obx(() {
        return Stack(
          children: [
            CustomPaint(
              painter: PathPainter(points: controller.points),
            ),
            ...buildMapMarkers(controller.markers)
          ],
        );
      }),
    );
  }

  List<Positioned> buildMapMarkers(List<MapMarker> markers) => markers
      .map((e) => Positioned(
            left: e.dx,
            top: e.dy,
            child: e.content,
          ))
      .toList();
}
