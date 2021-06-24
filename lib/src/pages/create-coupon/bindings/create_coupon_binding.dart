import 'package:get/get.dart';

import 'package:indoor_positioning_visitor/src/pages/create-coupon/controllers/create_coupon_controller.dart';

class CreateCouponBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCouponController>(() => CreateCouponController());
  }
}
