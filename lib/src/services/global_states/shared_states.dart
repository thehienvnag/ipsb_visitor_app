import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';

class SharedStates extends GetxService {
  /// selected bottom bar index
  final bottomBarSelectedIndex = 0.obs;

  // Coupon
  final coupon = Coupon().obs;

  // Coupon
  final couponInUse = CouponInUse().obs;
}
