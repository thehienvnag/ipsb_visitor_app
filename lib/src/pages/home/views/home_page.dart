import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/home/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
