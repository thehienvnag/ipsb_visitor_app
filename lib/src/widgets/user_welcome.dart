import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

class UserWelcome extends StatelessWidget {
  final Color textColor;
  final String? currentPosition;

  const UserWelcome({
    Key? key,
    this.textColor = Colors.white,
    this.currentPosition,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocationButton(
            textColor: textColor,
            currentPosition: currentPosition,
          ),
          ProfileIcon(),
        ],
      ),
    );
  }
}

class LocationButton extends StatelessWidget {
  final Color textColor;
  final String? currentPosition;

  const LocationButton(
      {Key? key, required this.textColor, this.currentPosition})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final SharedStates states = Get.find();
      final building = states.building.value;
      return TextButton(
        onPressed: () {
          if (building.id != null) {
            Get.toNamed(Routes.buildingDetails, parameters: {
              "id": building.id.toString(),
            });
          }
        },
        child: Row(
          children: [
            Icon(
              building.id != null ? Icons.apartment : Icons.location_on_rounded,
              color: building.id != null ? Colors.white : Colors.redAccent,
              size: 22,
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Text(
                Formatter.shorten(building.name, 24, currentPosition),
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ProfileIcon extends StatelessWidget {
  final SharedStates _sharedStates = Get.find();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!AuthServices.isLoggedIn()) {
          _sharedStates.showLoginBottomSheet();
        } else {
          Get.toNamed(Routes.profile);
        }
      },
      icon: Material(
        elevation: 6,
        shape: CircleBorder(
          side: BorderSide(color: Colors.white10, width: 0.5),
        ),
        child: Obx(
          () => CircleAvatar(
            backgroundColor: Colors.grey[100],
            backgroundImage: Utils.resolveNetworkImg(
              AuthServices.userLoggedIn.value.imageUrl,
              "assets/images/profile.png",
            ),
            radius: 35,
          ),
        ),
      ),
    );
  }
}
