import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/coupon_in_use.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_in_use_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/utils/firebase_helper.dart';

class MyCouponDetailController extends GetxController {
  /// save coupon for visitor
  ICouponInUseService couponInUseService = Get.find();

  // Share states across app
  final SharedStates sharedStates = Get.find();

  // Coupon in use
  final couponInUse = CouponInUse().obs;

  // Is getting coupon in use
  final isLoading = false.obs;

  int countCouponInUse = 0;

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
    isLoading.value = true;
    final result = await couponInUseService.getByVisitorIdAndCouponId(
      AuthServices.userLoggedIn.value.id!,
      int.parse(couponId),
    );
    // if (result == null) return;
    // if (result.status == couponInUse.value.status) {
    //   return;
    // } else {
    //   isLoading.value = true;
    // }
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
    if (couponUse.status == 'NotUsed') {
      return 3;
    }

    return 1;
  }

  Future<int> _countCouponInUseByCouponId(int couponId) async {
    return await couponInUseService.countCouponInUseByCouponId(
        {"couponId": couponId.toString(), "status": "Used"});
  }

  Future<void> saveCouponInUse(
      BuildContext context, int? couponId, int limit) async {
    if (!AuthServices.isLoggedIn()) {
      sharedStates.showLoginBottomSheet();
      return;
    }
    if (couponId == null) return;

    countCouponInUse = await _countCouponInUseByCouponId(couponId);
    if (countCouponInUse >= limit) {
      print(countCouponInUse);
      print(limit);
      showCustomDialog(context);
      return;
    }

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
      FirebaseHelper firebaseHelper = FirebaseHelper();
      await firebaseHelper.subscribeToTopic(
          "coupon_in_use_id_" + couponInUse.value.id.toString());
    }
  }

  void showCustomDialog(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final screenSize = MediaQuery.of(context).size;
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 12),
                  Container(
                    alignment: Alignment.center,
                    width: screenSize.width * 0.7,
                    color: Color(0xfffafafa),
                    child: Text(
                      'ERROR WHILE SAVING COUPON',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                    child: Text(
                      "Unable to save coupon due to the number of people using the code exceeding the limit ",
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    child: Text('Close',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                    onPressed: () => Get.back(),
                  )
                ],
              ),
            ),
          );
        },
      );
}
