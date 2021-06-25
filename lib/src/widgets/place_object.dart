import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:indoor_positioning_visitor/src/widgets/image_view/image_view_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/marker_popup.dart';

class PlaceConstants {
  static const String stairCase = "assets/images/staircase.png";
  static const String elevator = "assets/images/elevator.png";

  static const double radius = 20;
}

class PlaceObject extends GetView<ImageViewController> {
  final Location location;
  PlaceObject(
    this.location, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openPopup(location),
      child: Column(
        children: [
          AvatarGlow(
            endRadius: PlaceConstants.radius,
            child: Material(
              elevation: 8.0,
              shape:
                  CircleBorder(side: BorderSide(width: 3, color: Colors.white)),
              child: CircleAvatar(
                // backgroundColor: Colors.grey[100],
                backgroundColor: Colors.white,
                backgroundImage: determineImage(),
                radius: PlaceConstants.radius,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: GlowText(
              location.store?.name ?? '',
              blurRadius: 4,
              glowColor: Colors.grey.withOpacity(0.7),
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff1A73E8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  determineImage() {
    switch (location.locationTypeId) {
      case MarkerPopup.stairCase:
        return AssetImage(PlaceConstants.stairCase);
      case MarkerPopup.elevator:
        return AssetImage(PlaceConstants.elevator);
      case MarkerPopup.store:
        return location.retrieveStoreImg();
    }
  }
}
