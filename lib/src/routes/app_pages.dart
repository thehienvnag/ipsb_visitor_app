import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/feedback_coupon/bindings/feedback_coupon_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/feedback_coupon/views/feed_back_page.dart';
import 'package:indoor_positioning_visitor/src/pages/home/bindings/home_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/home/views/home_page.dart';
import 'package:indoor_positioning_visitor/src/pages/login_gmail/bindings/login_email_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/login_gmail/views/login_email_page.dart';
import 'package:indoor_positioning_visitor/src/pages/login_phone/bindings/login_phone_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/login_phone/views/login_phone_screen.dart';
import 'package:indoor_positioning_visitor/src/pages/login_phone/views/verify_phone_screen.dart';
import 'package:indoor_positioning_visitor/src/pages/map/views/map_page.dart';
import 'package:indoor_positioning_visitor/src/pages/building_details/bindings/building_detail_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/building_details/views/building_detail_page.dart';
import 'package:indoor_positioning_visitor/src/pages/building_store_list/bindings/building_store_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/building_store_list/views/building_store_list_page.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupon_detail/bindings/my_coupon_detail_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/bindings/my_coupon_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/profile/bindings/profile_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/profile/views/profile_page.dart';
import 'package:indoor_positioning_visitor/src/pages/profile_detail/bindings/profile_detail_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/profile_detail/views/profile_detail_page.dart';
import 'package:indoor_positioning_visitor/src/pages/setting/bindings/setting_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/setting/views/setting_page.dart';
import 'package:indoor_positioning_visitor/src/pages/test_algorithm/bindings/test_algorithm_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/test_algorithm/views/test_algorithm_page.dart';
import 'package:indoor_positioning_visitor/src/pages/update_infomation_signup/bindings/update_profile_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/update_infomation_signup/views/update_profile_page.dart';
import '../pages/my_coupon_detail/views/my_coupon_detail_page.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/views/my_coupon_page.dart';
import 'package:indoor_positioning_visitor/src/pages/notifications/bindings/notifications_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/notifications/views/notifications_page.dart';
import 'package:indoor_positioning_visitor/src/pages/show_coupon_qr/bindings/show_coupon_qr_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/show_coupon_qr/views/show_coupon_qr_page.dart';
import 'package:indoor_positioning_visitor/src/pages/store_details/bindings/store_details_binding.dart';
import 'package:indoor_positioning_visitor/src/pages/store_details/views/store_details_page.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/pages/map/bindings/map_binding.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.testAlgorithm,
      page: () => TestAlgorithmPage(),
      binding: TestAlgorithmBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.map,
      page: () => MapPage(),
      binding: MapBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.myCoupon,
      page: () => MyCouponPage(),
      binding: MyCouponBinding(),
      transition: Transition.noTransition,
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
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.buildingDetails,
      page: () => BuildingDetailPage(),
      binding: BuildingDetailBinding(),
    ),
    GetPage(
      name: Routes.buildingStore,
      page: () => BuildingStorePage(),
      binding: BuildingStoreBinding(),
    ),
    GetPage(
      name: Routes.feedbackCoupon,
      page: () => FeedbackCouponPage(),
      binding: FeedbackCouponBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginEmailPage(),
      binding: LoginEmailBinding(),
    ),
    GetPage(
      name: Routes.loginPhone,
      page: () => LoginPhonePage(),
      binding: LoginPhoneBinding(),
    ),
    GetPage(
      name: Routes.phoneVerify,
      page: () => VerifyPhoneScreen(),
      binding: LoginPhoneBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.profileDetail,
      page: () => ProfileDetailPage(),
      binding: ProfileDetailBinding(),
    ),
    GetPage(
      name: Routes.setting,
      page: () => SettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: Routes.updateProfile,
      page: () => UpdateProfilePage(),
      binding: UpdateProfileBinding(),
    ),
  ];
}
