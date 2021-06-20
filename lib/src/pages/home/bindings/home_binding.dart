import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/coupon_detail/controllers/coupon_detail_controller.dart';
import 'package:indoor_positioning_visitor/src/pages/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CouponDetailController>(() => CouponDetailController());
  }
}
