import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class MyCouponDetailController extends GetxController {
  final SharedStates sharedStates = Get.find();
  @override
  void onClose() {
    super.onClose();
    sharedStates.coupon.close();
    sharedStates.couponInUse.close();
  }
}
