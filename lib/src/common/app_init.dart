import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ipsb_visitor_app/src/algorithm/shortest_path/shortest_path.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/data/api_helper.dart';
import 'package:ipsb_visitor_app/src/models/edge.dart';
import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';
import 'package:ipsb_visitor_app/src/models/location_type.dart';
import 'package:ipsb_visitor_app/src/models/storage_list.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/services/api/account_service.dart';
import 'package:ipsb_visitor_app/src/services/api/building_service.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_in_use_service.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_service.dart';
import 'package:ipsb_visitor_app/src/services/api/edge_service.dart';
import 'package:ipsb_visitor_app/src/services/api/floor_plan_service.dart';
import 'package:ipsb_visitor_app/src/services/api/location_service.dart';
import 'package:ipsb_visitor_app/src/services/api/product_category_service.dart';
import 'package:ipsb_visitor_app/src/services/api/product_service.dart';
import 'package:ipsb_visitor_app/src/services/api/store_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_bottom_bar.dart';

class AppInit {
  static void init() {
    initMobileAppServices();
    initAlgorithmServices();
    initApiServices();
    initHiveStorage();
    initUserProfile();
  }

  /// Init mobile app services
  static void initMobileAppServices() {
    // Get image from file system
    Get.lazyPut<ImagePicker>(() => ImagePicker(), fenix: true);
    // Shared states between widget
    Get.lazyPut<SharedStates>(() => SharedStates(), fenix: true);
    // Bottom bar
    Get.lazyPut<CustomBottombarController>(
      () => CustomBottombarController(),
      fenix: true,
    );
  }

  static Future<void> initHiveStorage() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter<Edge>(EdgeAdapter())
      ..registerAdapter<Location>(LocationAdapter())
      ..registerAdapter<LocationType>(LocationTypeAdapter())
      ..registerAdapter<FloorPlan>(FloorPlanAdapter())
      ..registerAdapter<Store>(StoreAdapter())
      ..registerAdapter<StorageList<Edge>>(
        StorageListAdapter<Edge>(typeId: AppHiveType.storageListEdge),
      );
  }

  /// Init algorithms services
  static void initAlgorithmServices() {
    // Find shortest path algorithm
    Get.lazyPut<IShortestPath>(() => ShortestPath(), fenix: true);
  }

  /// Init api services
  static void initApiServices() {
    // Use for calling api
    Get.lazyPut<IApiHelper>(() => ApiHelper(), fenix: true);
    // Calling api at account service
    Get.lazyPut<IAccountService>(() => AccountService(), fenix: true);
    // Calling api at edge service
    Get.lazyPut<IEdgeService>(() => EdgeService(), fenix: true);
    // Calling api at location service
    Get.lazyPut<ILocationService>(() => LocationService(), fenix: true);
    // Calling api at store service
    Get.lazyPut<IStoreService>(() => StoreService(), fenix: true);
    // Calling api at product service
    Get.lazyPut<IProductService>(() => ProductService(), fenix: true);
    // Calling api at coupon service
    Get.lazyPut<ICouponService>(() => CouponService(), fenix: true);
    // Calling api at FloorPlan service
    Get.lazyPut<IFloorPlanService>(() => FloorPlanService(), fenix: true);
    // Calling api at couponInUse service
    Get.lazyPut<ICouponInUseService>(() => CouponInUseService(), fenix: true);
    // Calling api at ProductCategory service
    Get.lazyPut<IProductCategoryService>(() => ProductCategoryService(),
        fenix: true);
    Get.lazyPut<IBuildingService>(() => BuildingService(), fenix: true);
  }

  static void initUserProfile() {
    AuthServices.initUserFromPrevLogin();
  }
}
