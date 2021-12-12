import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaceNotRegisteredDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text("Direction route!"),
      ),
      content: Row(
        children: [
          Container(
            width: 220,
            child: Text("Place has not been registered !"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: true), // passing false
          child: Text('OK'),
        ),
      ],
    );
  }
}
