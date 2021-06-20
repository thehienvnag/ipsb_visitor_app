import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/coupon_detail/bindings/coupon_detail_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/coupon_detail/views/coupon_detail_page.dart';
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
    // GetPage(
    //   name: Routes.couponDetail,
    //   page: () => CouponDetailPage(),
    //   binding: CouponDetailBinding(),
    // ),
  ];
}
