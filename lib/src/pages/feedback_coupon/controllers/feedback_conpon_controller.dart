import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ipsb_visitor_app/src/models/coupon_in_use.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_in_use_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

class FeedbackCouponController extends GetxController {
  ICouponInUseService couponInUseService = Get.find();

  // Share states across app
  final SharedStates sharedStates = Get.find();

  ImagePicker _imagePicker = Get.find();
  final filePath = ''.obs;

  Future<void> getImage() async {
    filePath.value = '';
    final picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    filePath.value = picked?.path ?? '';
  }

  void deleteImage() {
    filePath.value = '';
  }

  final rating = 0.0.obs;

  var feedbackContent = "".obs;

  void saveFeedback(String content) {
    feedbackContent.value = content;
  }

  void changeRating(double number) {
    rating.value = number;
  }

  var couponId = 0.obs;

  Future<void> sendFeedback() async {
    CouponInUse coupon = sharedStates.couponInUse.value;
    final dateTime = DateTime.now();
    CouponInUse couponInUse = CouponInUse(
        id: coupon.id,
        applyDate: coupon.applyDate,
        visitorId: coupon.visitorId,
        couponId: coupon.couponId,
        redeemDate: coupon.redeemDate,
        status: coupon.status,
        feedbackContent: feedbackContent.value,
        feedbackImage: filePath.value,
        feedbackDate: dateTime,
        rateScore: rating.value);
    BotToast.showLoading();
    final result = await couponInUseService.putFeedbackCouponInUse(
        couponInUse, filePath.value, coupon.id!);

    BotToast.closeAllLoading();
    if (result) {
      BotToast.showText(text: "Feedback Success");
      Timer(Duration(seconds: 2), () {
        Get.offAllNamed(Routes.myCoupon);
      });
    }else{
      BotToast.showText(text: "Feedback Failed");
    }
  }
}
