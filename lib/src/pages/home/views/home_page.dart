
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/pages/coupon_detail/controllers/coupon_detail_controller.dart';
import 'package:indoor_positioning_visitor/src/pages/coupon_detail/views/coupon_detail_page.dart';

class HomePage extends GetView<CouponDetailController> {
  Coupon? model;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        model = controller.coupon_model.value;
        return Center(
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CouponDetailPage(model),
              ));
            },
            child: Text('Click to view detail'),
          ),
        );
      }),
    );
  }
}
