import 'package:get/get.dart';
import 'package:visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:visitor_app/src/pages/my_coupons/controllers/my_coupon_controller.dart';
import 'package:visitor_app/src/widgets/image_view/image_view_controller.dart';
import 'package:visitor_app/src/widgets/indoor_map/indoor_map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    // Bind My Coupon controller
    Get.lazyPut<MyCouponController>(() => MyCouponController(), fenix: true);
    // Bind map controller
    Get.lazyPut<ImageViewController>(() => ImageViewController(), fenix: true);
    // Bind map controller
    Get.lazyPut<IndoorMapController>(() => IndoorMapController(), fenix: true);
    // Bind Home controller
    Get.lazyPut<MapController>(() => MapController(), fenix: true);
  }
}
