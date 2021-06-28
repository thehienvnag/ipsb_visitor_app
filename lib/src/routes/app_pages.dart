import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/home/views/home_page.dart';
import 'package:indoor_positioning_visitor/src/pages/home/views/home_page_test.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupon_detail/bindings/my_coupon_detail_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/bindings/my_coupon_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/test_algorithm/bindings/test_algorithm_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/test_algorithm/views/test_algorithm_page.dart';
import '../pages/my_coupon_detail/views/my_coupon_detail_page.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/views/my_coupon_page.dart';
import 'package:indoor_positioning_visitor/src/pages/notifications/bindings/notifications_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/notifications/views/notifications_page.dart';
import 'package:indoor_positioning_visitor/src/pages/show_coupon_qr/bindings/show_coupon_qr_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/show_coupon_qr/views/show_coupon_qr_page.dart';
import 'package:indoor_positioning_visitor/src/pages/store_details/bindings/store_details_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/store_details/views/store_details_page.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/pages/home/bindings/home_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.testAlgorithm,
      page: () => TestAlgorithmPage(),
      binding: TestAlgorithmBinding(),
    ),
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
      binding: MyCouponDetailBinding(),
    ),
    GetPage(
      name: Routes.notifications,
      page: () => NotificationsPage(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: Routes.storeDetails,
      page: () => StoreDetailsPage(),
      binding: StoreDetailsBinding(),
    ),
  ];
}
