import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupon_detail/controllers/my_coupon_detail_controller.dart';

class MyCouponDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Bind My Coupon Details controller
    Get.lazyPut<MyCouponDetailController>(() => MyCouponDetailController());
  }
}