import 'package:get/get.dart';
import 'package:visitor_app/src/pages/show_coupon_qr/controllers/show_coupon_qr_controller.dart';

class ShowCouponQRBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Show Coupon QR controller
    Get.lazyPut<ShowCouponQRController>(() => ShowCouponQRController(),
        fenix: true);
  }
}
