import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';

class ShowCouponQRController extends GetxController {
  String genCode(Coupon coupon) {
    print('${coupon.storeId},${coupon.id},${coupon.code}');

    return '${coupon.storeId},${coupon.id},${coupon.code}';
  }
}
