import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class UserWelcome extends StatelessWidget {
  final Color textColor;

  const UserWelcome({Key? key, this.textColor = Colors.white})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocationButton(
            textColor: textColor,
          ),
          ProfileIcon(),
        ],
      ),
    );
  }
}

class LocationButton extends StatelessWidget {
  final Color textColor;

  const LocationButton({Key? key, required this.textColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: [
          Icon(
            Icons.location_on_rounded,
            color: Colors.redAccent,
            size: 22,
          ),
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Text(
              "Đại học FPT TP.HCM",
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
  }
}

class ProfileIcon extends StatelessWidget {
  final SharedStates _sharedStates = Get.find();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _sharedStates.showLoginBottomSheet();
      },
      icon: Material(
        elevation: 4,
        shape: CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: Image.asset("assets/images/profile.png"),
          radius: 30,
        ),
      ),
    );
  }
}
