import 'package:get/get.dart';
import 'package:visitor_app/src/models/coupon.dart';

class ShowCouponQRController extends GetxController {
  String genCode(Coupon coupon, int? couponInUseId) {
    print('${coupon.storeId},${coupon.id},$couponInUseId,${coupon.code}');
    return '${coupon.storeId},${coupon.id},$couponInUseId,${coupon.code}';
  }
}
