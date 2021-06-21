import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';

class SharedData extends GetxService {
  /// Coupon in use state
  final couponInUse = CouponInUse().obs;

  /// Save the coupon in use detail
  void saveCouponInUse(value) => couponInUse.value = value;

  /// Dispose coupon in use
  void disposeCouponInUse() => couponInUse.close();
}
