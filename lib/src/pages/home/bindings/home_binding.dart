import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/home/controllers/home_controller.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/controllers/my_coupon_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/image_view/image_view_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/indoor_map/indoor_map_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Bind My Coupon controller
    Get.lazyPut<MyCouponController>(() => MyCouponController());
    // Bind map controller
    Get.lazyPut<ImageViewController>(() => ImageViewController());
    // Bind map controller
    Get.lazyPut<IndoorMapController>(() => IndoorMapController());
    // Bind Home controller
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
