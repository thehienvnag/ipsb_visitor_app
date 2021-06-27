import 'dart:async';

import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/graph.dart';
import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/node.dart'
    as node;
import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/shortest_path.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/edge.dart';
import 'package:indoor_positioning_visitor/src/models/floor_plan.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/api/edge_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/floor_plan_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/location_service.dart';
import 'package:indoor_positioning_visitor/src/services/api/store_service.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';
import 'package:indoor_positioning_visitor/src/services/api/coupon_service.dart';
import 'package:indoor_positioning_visitor/src/widgets/indoor_map/indoor_map_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeController extends GetxController {
  final storePanelController = PanelController();
  final couponPanelController = PanelController();

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

  /// Get list stores when search
  final listStore = <Store>[].obs;

  //gọi locationTypeName, storeName, join list lại

  /// Get list search Store from api by buildingID,searchvalue, floorplanID
  Future<void> getStore(String value) async {
    // if (selectedFloorID == null) {
    //   return;
    // }
    changeVisible();
    storePanelController.open();
    final paging =
        await _storeService.getStores(value, selectedFloor.value.id!);
    listStore.value = paging.content!;
  }

  /// Get list floorPlan
  final listFloorPlan = <FloorPlan>[].obs;

  /// Get list FloorPlan from api by buildingID
  Future<List<int>> getFloorPlan() async {
    final paging = await _floorPlanService.getFloorPlans(12);
    listFloorPlan.value = paging.content!;
    selectedFloor.value = listFloorPlan[0];
    loadPlaceOnFloor(listFloorPlan[0].id!);
    return listFloorPlan.map((element) => element.id!).toList();
  }

  /// Get selected of floor
  var selectedFloor = FloorPlan().obs;

  /// Change selected of floor
  void changeSelectedFloor(FloorPlan? floor) {
    selectedFloor.value = floor!;
    loadPlaceOnFloor(floor.id!);
  }

  /// Go to coupon detail of selected
  void gotoCouponDetails(Coupon coupon) {
    sharedData.saveCoupon(coupon);
    Get.toNamed(Routes.couponDetail);
  }

  final isCouponBtnVisible = true.obs;

  void changeVisible() {
    isCouponBtnVisible.value = !isCouponBtnVisible.value;
  }

  IndoorMapController _mapController = Get.find();

  @override
  void onInit() {
    super.onInit();
    getFloorPlan().then((value) => loadEdgesInBuilding(value));
    getCoupons();
    onLocationChanged();
    testLocationChange();
  }

  void testLocationChange() {
    final list = [53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64];
    int index = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (index < list.length) {
        setCurrentLocation(list[index++]);
      }
    });
  }

  final edges = <Edge>[].obs;
  IEdgeService _edgeService = Get.find();
  Future<void> loadEdgesInBuilding(List<int> floorIds) async {
    final result = await _edgeService.getEdgesFromFloors(floorIds);
    edges.value = result;
  }

  ILocationService _locationService = Get.find();
  Future<void> loadPlaceOnFloor(int floorId) async {
    final locations = await _locationService.getLocationOnFloor(floorId);
    print(locations.length);
    _mapController.loadLocationsOnMap(locations);
  }

  final currentPosition = 0.obs;
  Future<void> setCurrentLocation(int id) async {
    if (id == 0) {
      return;
    }
    var position = locations[id]?.value;
    if (position == null) {
      position = await _locationService.getLocationById(id);
    }
    _mapController.setCurrentMarker(position);
  }

  IShortestPath _shortestPath = Get.find();

  final locations = RxMap<int, node.Node<Location>>({});
  void onLocationChanged() {
    currentPosition.listen((id) {
      setCurrentLocation(id);
      if (isShowingDirection.value) {
        showDirection();
      }
    });
  }

  final destPosition = 0.obs;
  final isShowingDirection = false.obs;
  Future<void> showDirection() async {
    if (edges.isEmpty) return;
    int from = currentPosition.value;
    int dest = destPosition.value;

    // If list of edges is available
    _mapController.setPathOnMap([]);
    Graph g = Graph.from(edges);

    //Set locationo
    locations.value = g.nodes;

    // Run Dijiktra algorithm
    _shortestPath.getShortestPath(g, dest);

    // Get shortest path
    final path = g.nodes[from]?.shortestPath.map((e) => e.value!).toList();

    if (path == null) return;
    _mapController.setPathOnMap(path);
  }

  /// [isShow] for home screen
  var isShow = false.obs;

  /// Change ishow value with true
  void changeIsShow() {
    isShow.value = true;
  }

  /// Change ishow value with false
  void changeIsShowFalse() {
    isShow.value = false;
  }
}
