import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class MyCouponDetailController extends GetxController {
  final dateTime = DateTime.now();
  final SharedStates sharedStates = Get.find();

  /// Check coupons of visitor save before with status is 'NotUse'
  bool checkCouponValid(String status, CouponInUse couponInUse) {
    bool result = false;
    if (couponInUse.status == status &&
        couponInUse.coupon!.publishDate!.compareTo(dateTime) < 0 &&
        couponInUse.coupon!.expireDate!.compareTo(dateTime) > 0) {
      result = true;
    }
    return result;
  }
}
