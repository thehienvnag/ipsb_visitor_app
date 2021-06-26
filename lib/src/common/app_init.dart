import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/shortest_path.dart';
import 'package:indoor_positioning_visitor/src/data/api_helper.dart';
import 'package:indoor_positioning_visitor/src/services/api/coupon_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/edge_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/floor_plan_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/location_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/store_service.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class AppInit {
  static void init() {
    initMobileAppServices();
    initAlgorithmServices();
    initApiServices();
  }

  /// Init mobile app services
  static void initMobileAppServices() {
    // Get image from file system
    Get.lazyPut<ImagePicker>(() => ImagePicker());
    // Shared states between widget
    Get.lazyPut<SharedStates>(() => SharedStates());
  }

  /// Init algorithms services
  static void initAlgorithmServices() {
    // Find shortest path algorithm
    Get.lazyPut<IShortestPath>(() => ShortestPath());
  }

  /// Init api services
  static void initApiServices() {
    // Use for calling api
    Get.lazyPut<IApiHelper>(() => ApiHelper());
    // Calling api at edge service
    Get.lazyPut<IEdgeService>(() => EdgeService());
    // Calling api at location service
    Get.lazyPut<ILocationService>(() => LocationService());
    // Calling api at Coupon service
    Get.lazyPut<ICouponService>(() => CouponService());
    // Calling api at Store service
    Get.lazyPut<IStoreService>(() => StoreService());
    // Calling api at FloorPlan service
    Get.lazyPut<IFloorPlanService>(() => FloorPlanService());
  }
}
