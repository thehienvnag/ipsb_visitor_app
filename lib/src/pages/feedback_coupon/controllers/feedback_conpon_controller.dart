import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/services/api/coupon_in_use_service.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class FeedbackCouponController extends GetxController {
  ICouponInUseService couponInUseService = Get.find();

  // Share states across app
  final SharedStates sharedStates = Get.find();

  ImagePicker _imagePicker = Get.find();
  final filePath = ''.obs;

  Future<void> getImage() async {
    final picked = await _imagePicker.getImage(source: ImageSource.gallery);
    filePath.value = picked?.path ?? '';
  }

  void deleteImage() {
    filePath.value = '';
  }

  final rating = 0.0.obs;

  var feedbackContent = "".obs;

  void saveFeedback(String content){
    feedbackContent.value = content;
  }


  void changeRating(double number){
    rating.value = number;
  }

  Future<void> sendFeedback(CouponInUse couponInUse) async {
    if (couponInUse == null) return;
    final dateTime = DateTime.now();
    CouponInUse feedback = CouponInUse(
      // couponId: couponInUse.couponId,
      // visitorId: couponInUse.visitor!.id,
      // redeemDate: couponInUse.redeemDate,
      // applyDate: couponInUse.applyDate,
      // status: couponInUse.status,
      feedbackContent: feedbackContent.value,
      feedbackImage: filePath.value,
      feedBackDate: dateTime,
      rateScore: rating.value
    );
    BotToast.showLoading();

    final result = await couponInUseService.putFeedbackCouponInUse(feedback);

    BotToast.closeAllLoading();
    if (result != null) {
      print("update success couponInUse with feedback");
    }
  }

}