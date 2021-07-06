import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:indoor_positioning_visitor/src/pages/feedback_coupon/controllers/feedback_conpon_controller.dart';

class FeedbackCouponBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Feedback_coupon controller
    Get.lazyPut<FeedbackCouponController>(() => FeedbackCouponController(), fenix: true);
  }
}