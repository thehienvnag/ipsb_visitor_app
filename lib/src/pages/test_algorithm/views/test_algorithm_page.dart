import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/test_algorithm/controllers/test_algorithm_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/indoor_map/indoor_map.dart';

class TestAlgorithmPage extends GetView<TestAlgorithmController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: IndoorMap(
            image: AssetImage('assets/images/floor_2_fptu.png'),
            loading: Text('Loading'),
          ),
        ),
      ),
    );
  }
}
