import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/pages/my_coupon_detail/controllers/my_coupon_detail_controller.dart';

class MyCouponDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Bind My Coupon Details controller
    Get.lazyPut<MyCouponDetailController>(() => MyCouponDetailController(),
        fenix: true);
  }
}
