import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/manage_coupon/controllers/manage_coupon_controller.dart';

class ManageCouponBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<ManageCouponController>(() => ManageCouponController());
  }
}
