import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/coupon_detail/controllers/coupon_detail_controller.dart';

class CouponDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Coupon Detail controller
    Get.lazyPut<CouponDetailController>(() => CouponDetailController());
  }
}
