import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/floor_plan.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/api/floor_plan_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/store_service.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';
import 'package:indoor_positioning_visitor/src/services/api/coupon_service.dart';

class HomeController extends GetxController {
  /// Shared data
  final SharedStates sharedData = Get.find();

  ICouponService _service = Get.find();
  IStoreService _storeService = Get.find();
  IFloorPlanService _floorPlanService = Get.find();

  /// [searchValue] for home screen
  var searchValue = "".obs;

  /// Get list coupons random data
  final listCoupon = <Coupon>[].obs;

  /// Get list Coupon from api
  Future<void> getCoupons() async {
    final paging = await _service.getCoupons();
    listCoupon.value = paging.content!;
  }

  /// Change search value with String [value]
  void changeSearchValue(String value) {
    searchValue.value = value;
  }

  /// Get list stores when search
  final listStore = <Store>[].obs;

  //gọi locationTypeName, storeName, join list lại

  /// Get list search Store from api by buildingID,searchvalue, floorplanID
  Future<void> getStore() async {
    final paging = await _storeService.getStores(1, searchValue.value, selectedFloorID!);
    listStore.value = paging.content!;
    print('name store : ' + searchValue.value);
    print('id floorPlan nè: ' + selectedFloorID.toString());
    print('list search nè : ' + listStore.value.length.toString());
  }

  /// Get list floorPlan
  final listFloorPlan = <FloorPlan>[].obs;

  /// Get list FloorPlan from api by buildingID
  Future<void> getFloorPlan() async {
    final paging = await _floorPlanService.getFloorPlans(1);
    listFloorPlan.value = paging.content!;
    selectedFloor.value = listFloorPlan.value[0];
  }

  /// Get selected of floor
  var selectedFloor = FloorPlan().obs;

  /// Get selected FloorId
  int? selectedFloorID;

  /// Change selected of floor
  void changeSelectedFloor(FloorPlan? floor) {
    selectedFloor.value = floor!;
    selectedFloorID = floor.id;
  }

  /// Go to coupon detail of selected
  void gotoCouponDetails(Coupon coupon) {
    sharedData.saveCoupon(coupon);
    Get.toNamed(Routes.couponDetail);
  }

  @override
  void onInit() {
    getCoupons();
    getFloorPlan();
    // getStore();
  }

}
