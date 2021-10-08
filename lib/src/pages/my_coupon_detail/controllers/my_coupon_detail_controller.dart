import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/coupon_in_use.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_in_use_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

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

    //checkStatus();
    getCouponInUse();
  }

  void checkStatus() {
    bool firstTime = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!firstTime) {
        getCouponInUse();
      }
      firstTime = false;
    });
  }

  void gotoShowQR() {
    sharedStates.couponInUse.value = couponInUse.value;
    Get.toNamed(Routes.showCouponQR);
  }

  Future<void> getCouponInUse() async {
    final couponId = Get.parameters['couponId'];
    if (couponId == null) return;
    if (!AuthServices.isLoggedIn()) return;
    final result = await couponInUseService.getByVisitorIdAndCouponId(
      AuthServices.userLoggedIn.value.id!,
      int.parse(couponId),
    );
    if (result == null) return;
    if (result.status == couponInUse.value.status) {
      return;
    } else {
      isLoading.value = true;
    }

    couponInUse.value = result;
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
    if (couponUse.status == 'NotUsed') {
      return 3;
    }

    return 1;
  }

  Future<void> saveCouponInUse(int? couponId) async {
    if (!AuthServices.isLoggedIn()) {
      sharedStates.showLoginBottomSheet();
      return;
    }
    if (couponId == null) return;
    final dateTime = DateTime.now();
    CouponInUse input = CouponInUse(
      couponId: couponId,
      visitorId: AuthServices.userLoggedIn.value.id,
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
