import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/controllers/my_coupon_controller.dart';

class MyCouponBinding extends Bindings {
  @override
  void dependencies() {
    // Bind My Coupon controller
    Get.lazyPut<MyCouponController>(() => MyCouponController());
  }
}