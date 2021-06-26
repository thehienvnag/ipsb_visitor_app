import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Function() onPressed;
  final double radius;
  final Icon icon;
  final Color? color;

  RoundedButton({
    Key? key,
    required this.onPressed,
    required this.radius,
    required this.icon,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color ?? Colors.grey.shade100,
        // Button color
        child: InkWell(
          splashColor: Colors.blueAccent, // Splash color
          onTap: onPressed,
          child: SizedBox(
            width: radius,
            height: radius,
            child: icon,
          ),
        ),
      ),
    );
  }
}
