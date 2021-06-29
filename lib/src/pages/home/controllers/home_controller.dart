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
    final paging = await _storeService.getStores(value, selectedFloor.value.id!);
    listStore.value = paging.content!;
  }

  /// Get list floorPlan
  final listFloorPlan = <FloorPlan>[].obs;

  /// Get list FloorPlan from api by buildingID
  Future<List<int>> getFloorPlan(Function() callback) async {
    final paging = await _floorPlanService.getFloorPlans(12);
    listFloorPlan.value = paging.content!;
    selectedFloor.value = listFloorPlan[0];
    callback.call();
    loadPlaceOnFloor(listFloorPlan[0].id!);

    return listFloorPlan.map((element) => element.id!).toList();
  }

  /// Get selected of floor
  var selectedFloor = FloorPlan().obs;

  /// Change selected of floor
  Future<void> changeSelectedFloor(FloorPlan? floor, [pressBtn = false]) async {
    if (floor?.id == selectedFloor.value.id) return;
    selectedFloor.value = floor!;

    setCurrentLocation(currentPosition.value, pressBtn);
    loadPlaceOnFloor(floor.id!);
    _mapController.setPathOnMap(shortestPath
        .where((element) => element.floorPlanId == selectedFloor.value.id)
        .toList());
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
    getFloorPlan(() => setCurrentLocation(53))
        .then((value) => loadEdgesInBuilding(value));
    getCoupons();

    onLocationChanged();
  }

  void testLocationChange() {
    final list = [
      54,
      55,
      56,
      57,
      58,
      59,
      60,
      61,
      62,
      63,
      64,
      65,
      66,
      67,
      68,
      69,
      70,
      71,
      72,
      73,
      74,
      75,
      76,
      77,
      78,
      79,
      80,
      81,
      82,
      83,
      84,
      85,
      86,
      87,
      88,
      89,
      90,
      91,
      92,
      93,
      116,
      141,
      142,
      143,
      144,
      145,
      146
    ];
    int index = -1;
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (index >= 0 && index < list.length) {
        setCurrentLocation(list[index]);
      }
      index++;
    });
  }

  final edges = <Edge>[].obs;
  IEdgeService _edgeService = Get.find();
  Future<void> loadEdgesInBuilding(List<int> floorIds) async {
    final result = await _edgeService.getAll();
    edges.value = result;
    // print(edges.length);
  }

  ILocationService _locationService = Get.find();
  Future<void> loadPlaceOnFloor(int floorId) async {
    _mapController.loadLocationsOnMap([]);
    final locations = await _locationService.getLocationOnFloor(floorId);
    print(locations.length);
    _mapController.loadLocationsOnMap(locations);
  }

  final currentPosition = 0.obs;
  Future<void> setCurrentLocation(int id, [pressBtn = false]) async {
    if (id == 0) {
      _mapController.setCurrentMarker(null);
    }
    currentPosition.value = id;
    var position = locations[id]?.value;

    if (position == null) {
      position = await _locationService.getLocationById(id);
    }
    final currentFloor = selectedFloor.value.id;
    if (currentFloor != position.floorPlanId && !pressBtn) {
      changeSelectedFloor(listFloorPlan
          .where(
            (e) => position?.floorPlanId == e.id!,
          )
          .first);
    }
    if (currentFloor == null)
      _mapController.setCurrentMarker(null);
    else if (currentFloor != position.floorPlanId)
      _mapController.setCurrentMarker(null);
    else
      _mapController.setCurrentMarker(position);
  }

  IShortestPath _shortestPath = Get.find();

  final locations = RxMap<int, node.Node<Location>>({});
  void onLocationChanged() {
    currentPosition.listen((id) {
      setCurrentLocation(id);
      // if (isShowingDirection.value) {
      //   showDirection(destPosition.value);
      // }
      showDirection(destPosition.value);
    });
  }

  final destPosition = 0.obs;
  final isShowingDirection = false.obs;
  final shortestPath = <Location>[].obs;
  Future<void> showDirection(int newDest) async {
    if (edges.isEmpty) return;
    int from = currentPosition.value;
    int dest = destPosition.value;

    // If list of edges is available
    _mapController.setPathOnMap([]);

    if (newDest != dest && edges.isNotEmpty) {
      destPosition.value = newDest;
      Graph g = Graph.from(edges);

      // Run Dijiktra algorithm
      _shortestPath.getShortestPath(g, destPosition.value);

      //Set locationo
      locations.value = g.nodes;
    }

    if (locations.isEmpty) return;

    node.Node<Location>? fromNode = locations[from];
    if (fromNode == null) return;
    // Get shortest path
    final path = fromNode.shortestPath
        .map(
          (e) => e.value!,
        )
        .toList()
        .reversed
        .toList();
    if (path.isEmpty) return;
    shortestPath.value = path;
    print(path);

    if (fromNode.value?.floorPlanId == selectedFloor.value.id) {
      _mapController.setPathOnMap(shortestPath
          .where((element) => element.floorPlanId == selectedFloor.value.id)
          .toList());
    } else {
      changeSelectedFloor(listFloorPlan
          .where(
            (e) => fromNode.value?.floorPlanId == e.id!,
          )
          .first);
    }
  }

  void startShowDirection(int? destId) {
    if (destId == null) return;
    isShowingDirection.value = true;
    showDirection(destId);
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
