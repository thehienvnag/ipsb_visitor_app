import 'package:com.ipsb.visitor_app/src/services/global_states/auth_services.dart';
import 'package:get/get.dart';
import 'package:com.ipsb.visitor_app/src/models/coupon.dart';
import 'package:com.ipsb.visitor_app/src/models/coupon_in_use.dart';
import 'package:com.ipsb.visitor_app/src/routes/routes.dart';
import 'package:com.ipsb.visitor_app/src/services/api/coupon_in_use_service.dart';

class MyCouponController extends GetxController {
  ICouponInUseService _service = Get.find();

  /// Get list all coupon of visitor save before
  final listCouponInUse = <CouponInUse>[].obs;

  /// Set list coupon of visitor save before
  Future<void> getCouponInUse() async {
    if (!AuthServices.isLoggedIn()) return;
    final paging = await _service.getCouponInUseByVisitorId(
      AuthServices.userLoggedIn.value.id!,
    );
    listCouponInUse.value = paging.content!;
  }

  void gotoCouponDetails(CouponInUse coupon) {
    Get.toNamed(Routes.couponDetail, parameters: {
      'couponId': coupon.couponId.toString(),
    });
  }

  /// Check coupons of visitor save before with status is 'NotUse'
  bool checkCouponValid(String status, CouponInUse couponInUse) {
    final dateTime = DateTime.now();
    bool result = false;
    if (couponInUse.status == status &&
        couponInUse.coupon!.publishDate!.compareTo(dateTime) < 0 &&
        couponInUse.coupon!.expireDate!.compareTo(dateTime) >= 0) {
      result = true;
    }
    return result;
  }

  /// Check coupons of visitor save before with Expriredate
  bool checkExpireCoupon(Coupon? coupon) {
    if (coupon == null) return false;
    final now = DateTime.now();
    return coupon.expireDate?.isBefore(now) ?? false;
  }

  @override
  void onInit() {
    super.onInit();
    getCouponInUse();
  }
}
