import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:visitor_app/src/common/constants.dart';
import 'package:visitor_app/src/models/location.dart';
import 'package:visitor_app/src/utils/utils.dart';
import 'package:visitor_app/src/widgets/image_view/image_view_controller.dart';

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
          if (!isStore())
            AvatarGlow(
              endRadius: MapKey.radius,
              child: Material(
                elevation: 8.0,
                shape: CircleBorder(
                  side: BorderSide(
                      width: location.storeId == null ? 3 : 0,
                      color: Colors.white),
                ),
                child: CircleAvatar(
                  // backgroundColor: Colors.grey[100],
                  backgroundColor: Colors.white,
                  backgroundImage:
                      Utils.getServiceImage(location.locationTypeId),
                  radius: MapKey.radius,
                ),
              ),
            ),
          if (isStore())
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  selected(controller.servicePopup.value),
                  if (!controller.servicePopup.value.enabled! ||
                      !checkCurrent(controller.servicePopup.value))
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: GlowText(
                        location.store?.name ?? '',
                        blurRadius: 2,
                        glowColor: Colors.grey.withOpacity(0.3),
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff5B7480),
                          fontWeight: FontWeight.w700,
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

  bool isStore() => location.locationTypeId == MapKey.store;

  Widget selected(PopupState state) {
    Widget icon = Icon(
      Icons.store,
      color: Color(0xff9AA0A6),
      size: 32,
    );

    if (state.enabled! && checkCurrent(state)) {
      icon = Transform.translate(
        offset: Offset(-6, -10),
        child: Icon(
          Icons.store,
          color: Color(0xffEA4335),
          size: 46,
        ),
      );
    }
    return icon;
  }

  bool checkCurrent(PopupState state) {
    return state.location?.id == location.id;
  }
}
