import 'dart:async';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/algorithm/shortest_path/graph.dart';
import 'package:ipsb_visitor_app/src/algorithm/shortest_path/shortest_path.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';
import 'package:ipsb_visitor_app/src/models/edge.dart';
import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/edge_service.dart';
import 'package:ipsb_visitor_app/src/services/api/floor_plan_service.dart';
import 'package:ipsb_visitor_app/src/services/api/location_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_service.dart';
import 'package:ipsb_visitor_app/src/services/storage/hive_storage.dart';
import 'package:ipsb_visitor_app/src/utils/edge_helper.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';
import 'package:ipsb_visitor_app/src/widgets/indoor_map/indoor_map_controller.dart';
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

  /// Determine whether to show Shopping bottom sheet
  final shoppingListVisble = false.obs;

  /// Determine whether shopping is starting
  final startShopping = false.obs;

  /// List store in turn of distance
  final listStoreShopping = <Store>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFloorPlan();
    loadEdgesInBuilding();
    getCoupons();
    onLocationChanged();
    loadShoppingList();
  }

  @override
  void onClose() {
    super.onClose();
    closeShopping();
  }

  void loadShoppingList() {
    if (sharedData.shoppingList.value.id == null) return;
    shoppingListVisble.value = true;
  }

  void beginShopping() {
    startShopping.value = true;
    int beginLocationId = currentPosition.value.id!;
    Graph graph = Graph.from(edges);
    final listStores = sharedData.shoppingList.value.getListStores();
    listStores.forEach((e) {
      int endLocationId = e.locations![0].id!;
      // Find all shortest paths to endLocationId
      _shortestPathAlgorithm.solve(graph, endLocationId);
      double distance = 0;
      List<Location> path = graph.getShortestPath(beginLocationId);
      int i = 0;
      path.forEach((e) {
        if (i < path.length - 1) {
          final p1 = Offset(e.x!, e.y!);
          final p2 = Offset(path[i + 1].x!, path[i + 1].y!);
          distance +=
              Utils.calDistance(p1, p2) / 30; // 30 is real scale of floor map
        }
        i++;
      });
      e.distance = distance;
    });
    listStores.sort((a, b) => a.distance!.compareTo(b.distance!));
    listStoreShopping.value = listStores;
    _mapController.setShoppingPoints(
      listStores
          .where((e) => e.locations![0].floorPlanId == selectedFloor.value.id)
          .toList(),
    );
    showDirectionForShopping();
  }

  void showDirectionForShopping() {
    if (!shoppingListVisble.value) return;
    List<Location> pathsOnMap = [];
    final initial = solveForShortestPath(
      currentPosition.value.id!,
      listStoreShopping[0].locations![0].id!,
    );
    pathsOnMap.addAll(initial);
    int pos = 0;
    listStoreShopping.forEach((e) {
      if (pos < listStoreShopping.length - 1) {
        Location p1 = e.locations![pos];
        Location p2 = e.locations![pos + 1];
        final pathTo = solveForShortestPath(
          p1.id!,
          p2.id!,
        );
        pathsOnMap.addAll(pathTo);
      }
      pos++;
    });
    shortestPath.value = pathsOnMap;
    _mapController.setPathOnMap(
      Graph.getPathOnFloor(shortestPath, selectedFloor.value.id!),
    );
  }

  bool checkComplete(int storeId) {
    bool result = false;
    try {
      final store = listStoreShopping.firstWhere((e) => e.id == storeId);
      result = store.complete;
    } catch (e) {}
    return result;
  }

  void onProductSelected(Product product, int storeId) {
    listStoreShopping.value = listStoreShopping.map((e) {
      if (e.id == storeId) {
        e.products!.forEach((pro) {
          if (pro.id == product.id) {
            pro.checked = !pro.checked;
          }
        });
        if (e.products!.every((pro) => pro.checked)) {
          e.complete = true;
        } else {
          e.complete = false;
        }
      }
      return e;
    }).toList();
    _mapController.setShoppingPoints(
      listStoreShopping
          .where((e) => e.locations![0].floorPlanId == selectedFloor.value.id)
          .toList(),
    );
  }

  void closeShopping() {
    shoppingListVisble.value = false;
    _mapController.setShoppingPoints([]);
    _mapController.setPathOnMap([]);
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
      showDirectionForShopping();
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

  List<Location> solveForShortestPath(int beginId, int endId) {
    // Init graph for finding shortest path from edges
    Graph graph = Graph.from(edges);
    // Find all shortest paths to endLocationId
    _shortestPathAlgorithm.solve(graph, endId);
    // Get shortest path for current position

    final paths = graph.getShortestPath(beginId);
    paths.insert(0, currentPosition.value);
    return paths;
  }

  void showDirection() {
    // Incase of edges is empty, end function
    if (edges.isEmpty) return;
    if (shoppingListVisble.value) return;
    isShowingDirection.value = true;

    int beginLocationId = currentPosition.value.id!;
    int endLocationId = destPosition.value;

    shortestPath.value = solveForShortestPath(beginLocationId, endLocationId);

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
    // final paging = await _service.getCoupons();
    // listCoupon.value = paging.content!;
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
        key: "edges_$buildingId",
      );
      // final dataFromAPI = await _edgeService.getByBuildingId(buildingId);
      // edges.value = EdgeHelper.splitToSegments(dataFromAPI);
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
    if (shoppingListVisble.isFalse) {
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
    } else {}
  }
}
