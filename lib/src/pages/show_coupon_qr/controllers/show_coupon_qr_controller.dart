import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';

class ShowCouponQRController extends GetxController {
  String genCode(Coupon coupon, int? couponInUseId) {
    return '${coupon.storeId},${coupon.id},$couponInUseId,${coupon.code}';
  }
}
