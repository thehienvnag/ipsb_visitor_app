import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/pages/my_coupons/controllers/my_coupon_controller.dart';

class MyCouponBinding extends Bindings {
  @override
  void dependencies() {
    // Bind My Coupon controller
    Get.lazyPut<MyCouponController>(() => MyCouponController(), fenix: true);
  }
}
