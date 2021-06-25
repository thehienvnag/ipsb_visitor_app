import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  static const double radius = 40;
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: Colors.cyan,
      endRadius: radius,
      duration: Duration(milliseconds: 1500),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 50),
      child: Material(
        // Replace this child with your own
        elevation: 8.0,
        shape: CircleBorder(
          side: BorderSide(width: 2.5, color: Colors.white),
        ),
        child: CircleAvatar(
          backgroundColor: Color(0XFF4086F4),
          radius: 17.0,
        ),
      ),
    );
  }
}
