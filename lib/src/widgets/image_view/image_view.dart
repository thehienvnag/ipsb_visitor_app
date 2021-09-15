import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ipsb.visitor_app/src/common/constants.dart';
import 'package:com.ipsb.visitor_app/src/widgets/current_location.dart';
import 'package:com.ipsb.visitor_app/src/widgets/image_view/image_view_controller.dart';
import 'package:com.ipsb.visitor_app/src/widgets/image_view/map_marker.dart';
import 'package:com.ipsb.visitor_app/src/widgets/path_painter.dart';
import 'package:com.ipsb.visitor_app/src/widgets/marker_popup.dart';

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
    return GestureDetector(
      onTap: () => controller.closeAllPopup(),
      child: Container(
        padding: const EdgeInsets.only(bottom: 90, top: 40),
        color: Colors.white,
        // padding:
        //     const EdgeInsets.only(top: 200, bottom: 600, left: 200, right: 200),
        // decoration: BoxDecoration(color: Colors.transparent),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(image: image),
            // border: Border.all(color: Colors.grey.shade300),
            // borderRadius: BorderRadius.circular(8)
          ),
          child: Obx(() {
            return Stack(
              children: [
                CustomPaint(
                  painter: PathPainter(points: controller.points),
                ),
                ...buildMapMarkers(controller.markers),
                buildOneMarker(controller.point.value),
                buildPopup(controller.servicePopup.value, width, height),
              ],
            );
          }),
        ),
      ),
    );
  }

  List<Positioned> buildMapMarkers(List<MapMarker> markers) => markers
      .map((e) => Positioned(
            left: e.dx - MapKey.radius,
            top: e.dy - MapKey.radius,
            child: e.content,
          ))
      .toList();

  Positioned buildOneMarker(MapMarker marker) => Positioned(
        left: marker.dx - CurrentLocation.radius,
        top: marker.dy - CurrentLocation.radius,
        child: marker.content,
      );

  Positioned buildPopup(
    PopupState popupState,
    double width,
    double height,
  ) {
    if (popupState.enabled!) {
      return Positioned(
        left: determineLocation(
          popupState.locationR.dx,
          popupState.width!,
          width,
          popupState.offset.dx,
        ),
        top: determineLocation(
              popupState.locationR.dy,
              popupState.height!,
              height,
              popupState.offset.dy,
            ) -
            MapKey.radius,
        child: MarkerPopup(state: popupState),
      );
    }
    return Positioned(child: SizedBox());
  }

  double determineLocation(
    double dOffset,
    double popupSize,
    double screenSize,
    double offset,
  ) {
    dOffset += offset;
    double widthEnd = dOffset + popupSize;
    double value = widthEnd > screenSize
        ? dOffset - popupSize - MapKey.radius * 3
        : dOffset;
    return value;
  }
}
