import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';

class DirectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Image.asset(ConstImg.checkWatermark, width: 30),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text("Complete route!"),
          ),
        ],
      ),
      content: Row(
        children: [
          Container(
            child: Text("You have come to your destination"),
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
