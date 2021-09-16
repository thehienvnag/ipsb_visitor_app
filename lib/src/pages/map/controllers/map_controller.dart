import 'dart:async';

import 'package:get/get.dart';
import 'package:visitor_app/src/algorithm/shortest_path/graph.dart';
import 'package:visitor_app/src/algorithm/shortest_path/shortest_path.dart';
import 'package:visitor_app/src/common/constants.dart';
import 'package:visitor_app/src/models/coupon.dart';
import 'package:visitor_app/src/models/edge.dart';
import 'package:visitor_app/src/models/floor_plan.dart';
import 'package:visitor_app/src/models/location.dart';
import 'package:visitor_app/src/routes/routes.dart';
import 'package:visitor_app/src/services/api/edge_service.dart';
import 'package:visitor_app/src/services/api/floor_plan_service.dart';
import 'package:visitor_app/src/services/api/location_service.dart';
import 'package:visitor_app/src/services/global_states/shared_states.dart';
import 'package:visitor_app/src/services/api/coupon_service.dart';
import 'package:visitor_app/src/services/storage/hive_storage.dart';
import 'package:visitor_app/src/utils/edge_helper.dart';
import 'package:visitor_app/src/widgets/indoor_map/indoor_map_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapController extends GetxController {
  /// Panel controller for scroll up panel
  PanelController couponPanelController = PanelController();

  /// Indoor map controller
  IndoorMapController _mapController = Get.find();

  /// Shared data
  SharedStates sharedData = Get.find();

  /// Shortest path algorithm
  IShortestPath _shortestPathAlgorithm = Get.find();

  /// Service for interacting with FloorPlan API
  IFloorPlanService _floorPlanService = Get.find();

  /// Service for interacting with Coupon API
  ICouponService _service = Get.find();

  /// Service for interacting with Location API
  ILocationService _locationService = Get.find();

  /// Service for interacting with Edge API
  IEdgeService _edgeService = Get.find();

  /// List edges of all of the building
  final edges = <Edge>[].obs;

  /// List search of location
  final searchLocationList = <Location>[].obs;

  /// Determine whether the search operation is completed
  final isSearchingLocationList = false.obs;

  /// List coupons to show to visitor from bottom sheet
  final listCoupon = <Coupon>[].obs;

  /// List floor plan for dropdown list to change floor
  final listFloorPlan = <FloorPlan>[].obs;

  /// Selected floor for dropdown list
  var selectedFloor = FloorPlan().obs;

  /// Current position of visitor, determine by locationId
  final currentPosition = Location(
    id: 276,
    x: 149.38747406005859,
    y: 204.60000228881836,
    floorPlanId: 12,
    locationTypeId: 2,
  ).obs;

  /// Destination position where visitor want to come
  final destPosition = 0.obs;

  /// Determine whether a path is shown
  final isShowingDirection = false.obs;

  /// Shortest path for one specific current and destination
  final shortestPath = <Location>[].obs;

  /// Determine whether the navigation panel is shown or not
  var isShowNavigationPanel = false.obs;

  /// Determine whether the coupon button is shown or not
  final isCouponBtnVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    getFloorPlan();
    loadEdgesInBuilding();
    getCoupons();
    onLocationChanged();
  }

  void startShowDirection(int? destLocationId) {
    if (destLocationId == null) return;
    destPosition.value = destLocationId;
    showDirection();
  }

  void onLocationChanged() {
    // _mapController.moveToScene(Location(x: 100, y: 100));
    _mapController.setCurrentMarker(currentPosition.value);
    currentPosition.listen((location) {
      showDirection();
      checkCurrentLocationOnFloor();
      _mapController.moveToScene(location);
    });
  }

  void checkCurrentLocationOnFloor() {
    if (currentPosition.value.floorPlanId != selectedFloor.value.id) {
      changeSelectedFloor(
        listFloorPlan
            .where((floor) => floor.id == currentPosition.value.floorPlanId)
            .first,
      );
    }
  }

  void showDirection() {
    // Incase of edges is empty, end function
    if (edges.isEmpty) return;
    // print("[ShowDirection]__________");
    isShowingDirection.value = true;

    int beginLocationId = currentPosition.value.id!;
    int endLocationId = destPosition.value;

    // Init graph for finding shortest path from edges
    Graph graph = Graph.from(edges);
    // Find all shortest paths to endLocationId
    _shortestPathAlgorithm.solve(graph, endLocationId);
    // Get shortest path for current position

    shortestPath.value = graph.getShortestPath(beginLocationId);
    shortestPath.insert(0, currentPosition.value);
    // shortestPath.forEach((element) {
    //   print(element);
    // });
    // Set path on map
    _mapController.setPathOnMap(
      Graph.getPathOnFloor(shortestPath, selectedFloor.value.id!),
    );
    isShowingDirection.value = false;
  }

  Future<void> setCurrentLocation(Location? location,
      [pressBtn = false]) async {
    if (location == null) return;
    // print("[SetCurrentLocation]");
    // print(location);
    currentPosition.value = location;
    _mapController.setCurrentMarker(location);
  }

  /// Change selected of floor
  Future<void> changeSelectedFloor(FloorPlan? floor) async {
    if (floor?.id == selectedFloor.value.id) return;
    selectedFloor.value = floor!;
    loadPlaceOnFloor(floor.id!);
    _mapController.setPathOnMap(
      Graph.getPathOnFloor(shortestPath, floor.id!),
    );
    if (currentPosition.value.floorPlanId != selectedFloor.value.id) {
      _mapController.setCurrentMarker(null);
    }
  }

  Future<void> searchLocations(String keySearch) async {
    if (keySearch.isEmpty) {
      searchLocationList.clear();
      return;
    }
    int? buildingId = sharedData.building.value.id;
    if (buildingId != null && !isSearchingLocationList.value) {
      isSearchingLocationList.value = true;
      searchLocationList.value = await _locationService.getLocationByKeySearch(
          buildingId.toString(), keySearch);
      Timer(Duration(seconds: 1), () => isSearchingLocationList.value = false);
    }
  }

  /// Get list Coupon from api
  Future<void> getCoupons() async {
    final paging = await _service.getCoupons();
    listCoupon.value = paging.content!;
  }

  /// Get list FloorPlan from api by buildingID
  Future<List<int>> getFloorPlan() async {
    final paging = await _floorPlanService.getFloorPlans(12);
    listFloorPlan.value = paging.content!;
    selectedFloor.value = listFloorPlan[0];
    loadPlaceOnFloor(listFloorPlan[0].id!);
    return listFloorPlan.map((element) => element.id!).toList();
  }

  /// Go to coupon detail of selected
  void gotoCouponDetails(Coupon coupon) {
    sharedData.coupon.value = coupon;
    Get.toNamed(Routes.couponDetail, parameters: {
      'couponId': coupon.id.toString(),
    });
  }

  void changeVisible() {
    isCouponBtnVisible.value = !isCouponBtnVisible.value;
  }

  Future<void> loadEdgesInBuilding() async {
    int? buildingId = sharedData.building.value.id;
    if (buildingId != null) {
      final edgesResult = await HiveStorage.useStorageList<Edge>(
        apiCallback: () => _edgeService.getByBuildingId(buildingId),
        transformData: EdgeHelper.splitToSegments,
        storageBoxName: StorageConstants.edgeBox,
        key: buildingId,
      );
      edges.value = edgesResult;
    }
  }

  Future<void> loadPlaceOnFloor(int floorId) async {
    final locations = await _locationService.getLocationOnFloor(floorId);
    _mapController.loadLocationsOnMap(locations);
  }

  /// Change ishow value with true
  void changeIsShow() {
    isShowNavigationPanel.value = true;
  }

  /// Change ishow value with false
  void changeIsShowFalse() {
    isShowNavigationPanel.value = false;
  }

  /// TEST FUNCTION (Removed when completed)
  void testLocationChange() {
    int index = -1;
    final paths = shortestPath.map((e) => e).toList();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      if (isShowingDirection.isFalse) {
        if (index >= 0 && index < paths.length) {
          setCurrentLocation(paths[index]);
        }
        if (index == paths.length) {
          print("cancel");
          timer.cancel();
        }
        index++;
      }
    });
  }
}
