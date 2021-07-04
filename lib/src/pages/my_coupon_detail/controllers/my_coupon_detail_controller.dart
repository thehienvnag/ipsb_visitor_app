import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/api/coupon_in_use_service.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class MyCouponDetailController extends GetxController {
  /// save coupon for visitor
  ICouponInUseService couponInUseService = Get.find();

  // Share states across app
  final SharedStates sharedStates = Get.find();

  // Coupon in use
  final couponInUse = CouponInUse().obs;

  // Is getting coupon in use
  final isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    getCouponInUse();
  }

  void gotoShowQR() {
    sharedStates.couponInUse.value = couponInUse.value;
    Get.toNamed(Routes.showCouponQR);
  }

  Future<void> getCouponInUse() async {
    isLoading.value = true;
    final couponId = Get.parameters['couponId'];
    if (couponId == null) return;
    final result = await couponInUseService.getByVisitorIdAndCouponId(
      9,
      int.parse(couponId),
    );
    if (result != null) {
      couponInUse.value = result;
    }
    isLoading.value = false;
  }

  /// Check coupons of visitor save before with status is 'NotUse'
  int checkCouponState() {
    final coupon = sharedStates.coupon.value;
    final couponUse = couponInUse.value;
    if (coupon.id != null && couponUse.id == null) {
      return 1;
    }
    final now = DateTime.now();
    if (couponUse.status == 'Used' ||
        couponUse.coupon!.expireDate!.isBefore(now)) {
      return 2;
    }
    if (couponUse.status == 'New') {
      return 3;
    }

    return 1;
  }

  Future<void> saveCouponInUse(int? couponId) async {
    if (couponId == null) return;
    final dateTime = DateTime.now();
    CouponInUse input = CouponInUse(
      couponId: couponId,
      visitorId: 9,
      redeemDate: dateTime,
      status: "Active",
    );
    BotToast.showLoading();

    final result = await couponInUseService.createCouponInUse(input);

    BotToast.closeAllLoading();
    if (result != null) {
      final coupon = couponInUse.value.coupon ?? sharedStates.coupon.value;
      result.coupon = coupon;
      couponInUse.value = result;
    }
  }
}
