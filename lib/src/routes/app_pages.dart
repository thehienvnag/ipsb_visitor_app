import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/bindings/my_coupon_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/views/my_coupon_detail_page.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/views/my_coupon_page.dart';
import 'package:indoor_positioning_visitor/src/pages/show_coupon_qr/bindings/show_coupon_qr_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/show_coupon_qr/views/show_coupon_qr_page.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/pages/home/bindings/home_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/home/views/home_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.myCoupon,
      page: () => MyCouponPage(),
      binding: MyCouponBinding(),
    ),
    GetPage(
      name: Routes.showCouponQR,
      page: () => ShowCouponQRPage(),
      binding: ShowCouponQRBinding(),
    ),
    GetPage(
      name: Routes.couponDetail,
      page: () => MyCouponDetailPage(),
      binding: MyCouponBinding(),
    ),
  ];
}
