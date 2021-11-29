import 'dart:async';

import 'package:flutter_compass/flutter_compass.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ipsb_positioning.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/beacon.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/ble_positioning.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/pdr_positioning.dart';
import 'package:ipsb_visitor_app/src/algorithm/shortest_path/graph.dart';
import 'package:ipsb_visitor_app/src/algorithm/shortest_path/shortest_path.dart';
import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/models/coupon.dart';
import 'package:ipsb_visitor_app/src/models/edge.dart';
import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/models/shopping_list.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/pages/map/views/direction_dialog.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/building_service.dart';
import 'package:ipsb_visitor_app/src/services/api/coupon_service.dart';
import 'package:ipsb_visitor_app/src/services/api/edge_service.dart';
import 'package:ipsb_visitor_app/src/services/api/floor_plan_service.dart';
import 'package:ipsb_visitor_app/src/services/api/location_service.dart';
import 'package:ipsb_visitor_app/src/services/api/locator_tag_service.dart';
import 'package:ipsb_visitor_app/src/services/api/shopping_list_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/utils/edge_helper.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/widgets/indoor_map/indoor_map_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapController extends GetxController {
  /// Panel controller for scroll up panel
  PanelController couponPanelController = PanelController();

  /// Indoor map controller
  IndoorMapController _mapController = Get.find();

  /// Shared data
  SharedStates sharedData = Get.find();

  /// Shopping list service
  IShoppingListService _shoppingListService = Get.find();

  /// Shortest path algorithm
  IShortestPath _shortestPathAlgorithm = Get.find();

  /// Service for interacting with FloorPlan API
  IFloorPlanService _floorPlanService = Get.find();

  /// Service for interacting with Coupon API
  ICouponService _couponService = Get.find();

  /// Service for interacting with Location API
  ILocationService _locationService = Get.find();

  /// Service for interacting with Edge API
  IEdgeService _edgeService = Get.find();

  /// Service for interacting with LocatorTag API
  ILocatorTagService _locatorTagService = Get.find();

  /// Service for interacting with Building API
  IBuildingService buildingService = Get.find();

  /// List edges of all of the building
  final edges = <Edge>[].obs;

  /// List locations on map
  final locationsOnMap = <Location>[].obs;

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
    id: -1,
    x: 500.364990234375,
    y: 280.16999053955078,
    floorPlanId: 13,
    locationTypeId: 2,
  ).obs;

  /// Destination position where visitor want to come
  final destPosition = 0.obs;

  /// Determine whether a path is shown
  final isShowingDirection = false.obs;

  /// Is direction bottom sheet visible
  final directionBottomSheet = false.obs;

  /// Shortest path for one specific current and destination
  final shortestPath = <Location>[].obs;

  /// Determine whether the navigation panel is shown or not
  var isShowNavigationPanel = false.obs;

  /// Determine whether the coupon button is shown or not
  final isCouponBtnVisible = true.obs;

  /// Determine whether to show Shopping bottom sheet
  final shoppingListVisble = false.obs;

  /// List store in turn of distance
  final listStoreShopping = <Store>[].obs;

  /// List shopping routes;
  final listShoppingRoutes = <List<Location>>[].obs;

  /// Current position address
  final currentAddress = "".obs;

  /// Loading map
  final isLoading = false.obs;

  /// Distance to destination
  final distanceToDest = (-1.0).obs;

  /// Show complete route dialog
  final completeRoute = false.obs;

  /// Current direction storeName;
  final currentStoreName = "".obs;

  /// Ble config
  BlePositioningConfig? _bleConfig;

  /// Pdr config
  PdrPositioningConfig? _pdrConfig;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    initBuilding().then((result) {
      if (result) {
        getFloorPlan().then((value) {
          initPositioning();
          loadEdgesInBuilding().then((value) {
            initShoppingList();
            // currentPosition.value =
            //     EdgeHelper.findNearestLocation(edges, currentPosition.value);
          });
          loadPlaceOnBuilding();
          isLoading.value = false;
        }).catchError((err) {
          isLoading.value = false;
        });
        onSelectedFloorChange();
        onLocationChanged();
      }
    });
    // initRotateMap();
  }

  @override
  void onClose() {
    super.onClose();
    // closeShopping();
    closeRotateMap();
    IpsbPositioning.stop();
  }

  Future<bool> initBuilding() async {
    if (sharedData.building.value.id != null) return true;
    Position? myLocation;
    try {
      myLocation = await Geolocator.getCurrentPosition();
    } catch (e) {}

    if (myLocation == null) return false;

    final building = await buildingService.findCurrentBuilding(
      myLocation.latitude,
      myLocation.longitude,
    );
    if (building != null) {
      sharedData.building.value = building;
      return true;
    } else {
      sharedData.building.value = Building();
      List<geocoding.Placemark> placeMarks =
          await geocoding.placemarkFromCoordinates(
        myLocation.latitude,
        myLocation.longitude,
      );
      if (placeMarks.isNotEmpty) {
        final place = placeMarks.first;
        currentAddress.value = Formatter.formatAddress(place);
      } else {
        currentAddress.value = 'Location not found';
      }
    }

    return false;
  }

  /// Rotate angle
  final rotateAngle = 0.0.obs;

  /// Compass subscription
  StreamSubscription<CompassEvent>? compassSubscription;
  void initRotateMap() {
    rotateAngle.listen((e) => onRotateChange(e));
    compassSubscription = FlutterCompass.events?.listen((e) {
      rotateAngle.value = e.heading ?? 0;
    });
  }

  /// Close rotate on map
  void closeRotateMap() {
    compassSubscription?.cancel();
    rotateAngle.value = 0;
  }

  /// On rotate value changes
  void onRotateChange(double rotate) {
    _mapController.rotateCamera(rotate);
  }

  void initPositioning() async {
    if (listFloorPlan.isEmpty) return; // If get none floorplan, stop!

    final beacons = (await _locatorTagService
            .getByBuildingId(sharedData.building.value.id!))
        .where((e) => e.location != null) // Hard code buildingId
        .map(
          (e) => Beacon(
            id: e.id,
            uuid: e.uuid,
            txPower: e.txPower!,
            location: Location2d(
              x: e.location!.x!,
              y: e.location!.y!,
              floorPlanId: e.floorPlanId!,
            ),
            beaconGroupId: e.locatorTagGroupId,
          ),
        )
        .toList();

    _bleConfig = BlePositioningConfig(
      beacons: beacons,
      mapScale: selectedFloor.value.mapScale!,
    );

    _pdrConfig = PdrPositioningConfig(
      rotationAngle: selectedFloor.value.rotationAngle!,
      mapScale: selectedFloor.value.mapScale!,
    );

    IpsbPositioning.start<Location>(
      pdrConfig: _pdrConfig!,
      bleConfig: _bleConfig!,
      resultTranform: (location2d) => Location(
        // id: 20000,
        x: location2d.x,
        y: location2d.y,
        locationTypeId: 2,
        floorPlanId: location2d.floorPlanId,
      ),
      onChange: (newLocation, currentFloor, setCurrent) {
        if (currentFloor != null) {
          final floor = listFloorPlan.firstWhere(
            (floor) => floor.id == currentFloor,
            orElse: () => FloorPlan(),
          );
          if (floor.id != null) {
            changeSelectedFloor(floor);
          }
        }
        final location = EdgeHelper.findNearestLocation(edges, newLocation);
        if (location.id != null) {
          currentPosition.value = location;
        }
        // final location =
        //     EdgeHelper.edgesWithCurrentLocation(edges, currentPosition.value)
        //         .projection;
        // if (location != null) {
        //   currentPosition.value = location;
        // }
      },
    );
  }

  void initShoppingList() {
    if (sharedData.shoppingList.value.id == null) return;
    shoppingListVisble.value = true;

    /// Stream of list shopping stores changed
    listStoreShopping.listen((stores) {
      _mapController.setShoppingPoints(Graph.getShoppingPoints(
        stores,
        selectedFloor.value.id!,
      ));
    });

    /// Stream of list shopping routes changed
    listShoppingRoutes.listen((e) => setShoppingRoutes(e));
    if (sharedData.startShopping.isTrue) {
      beginShopping();
    }
  }

  bool isShoppingComplete() => listStoreShopping.every((e) => e.complete);

  void setShoppingRoutes(List<List<Location>> shoppingRoutes) {
    if (sharedData.startShopping.isFalse) {
      // Set locations as Active routes
      _mapController.setActiveRoute([]);
      // Set locations as Inactive routes
      _mapController.setInActiveRoute([]);
      return;
    }
    if (shoppingRoutes.isEmpty) return;

    // The 1st route
    final firstRoute = shoppingRoutes[0];
    // The remaining routes
    final remainings = shoppingRoutes
        .getRange(1, shoppingRoutes.length)
        .expand((route) => route);

    // Set locations as Active routes
    _mapController.setActiveRoute(
      Graph.getRouteOnFloor(firstRoute, selectedFloor.value.id!),
    );
    // Set locations as Inactive routes
    _mapController.setInActiveRoute(
      Graph.getRouteOnFloor(remainings, selectedFloor.value.id!),
    );
  }

  /// Begin shopping
  void beginShopping() {
    if (edges.isEmpty) return;

    sharedData.startShopping.value = true;

    // Init list shopping points (store on map)
    listStoreShopping.value = sharedData.shoppingList.value.getListStores();

    // Show direction
    showShoppingDirections();

    // Init store positions
    int i = 0;
    listStoreShopping.forEach((e) => e.pos = ++i);
    listStoreShopping.refresh();
  }

  void showShoppingDirections() {
    if (sharedData.startShopping.isFalse) return;
    if (listStoreShopping.every((e) => e.complete)) {
      listShoppingRoutes.clear();
      _mapController.setActiveRoute([]);
      _mapController.setInActiveRoute([]);
      return;
    }

    int? beginId = currentPosition.value.id;
    if (beginId == null) return;
    Graph graph = Graph.from(
      // EdgeHelper.edgesWithCurrentLocation(edges, currentPosition.value).
      edges,
    );

    // Sort the store by the distance from current position
    graph.sortStoreByDistance(
      beginId,
      listStoreShopping,
      edges,
      listFloorPlan,
      solveForShortestPath,
    );
    // Sort the store by the distance from current position
    listShoppingRoutes.value = graph.getShoppingRoutes(
      beginId,
      listStoreShopping.where((e) => !e.complete).toList(),
      solveForShortestPath,
    );
  }

  /// Check complete
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
        e.changeProductSelected(
          product,
        );
      }
      return e;
    }).toList();
    showShoppingDirections();
  }

  void completeShopping(int id) {
    _shoppingListService.completeShopping(id);
    closeShopping();
  }

  void closeShopping() {
    shoppingListVisble.value = false;
    sharedData.startShopping.value = false;
    sharedData.shoppingList.value = ShoppingList();
    listStoreShopping.clear();
    listShoppingRoutes.clear();
  }

  void openDirectionMenu(int? destLocationId) {
    if (destLocationId == null || currentPosition.value.id == null) return;
    stopDirection();
    directionBottomSheet.value = true;
    destPosition.value = destLocationId;
    solveForShortestPath(
      currentPosition.value.id!,
      destLocationId,
      showDirection: true,
    );
  }

  void closeDirectionMenu() {
    if (directionBottomSheet.isTrue) {
      stopDirection();
      directionBottomSheet.value = false;
    }
  }

  Map<String, dynamic>? getDirectionDetails(int? destId, double? distanceTo) {
    Map<String, dynamic>? data;
    if (destId != null) {
      data = {};
      if (distanceTo != -1) {
        data.putIfAbsent("distanceTo", () => distanceTo);
      }
      final location = locationsOnMap.firstWhere(
        (element) => element.id == destId,
        orElse: () => Location(),
      );
      var title = 'Floor ${location.floorPlan?.floorCode}';
      String? imageUrl;

      if (location.locationTypeId == 1) {
        imageUrl = location.store?.imageUrl;
        title = '${location.store?.name} - $title';
      } else {
        imageUrl = location.locationType?.imageUrl;
        title = '${location.locationType?.name} - $title';
      }
      currentStoreName.value = title;
      data.putIfAbsent("imageUrl", () => imageUrl);
      data.putIfAbsent("title", () => title);
    }
    return data;
  }

  void startShowDirection() {
    if (directionBottomSheet.isTrue) {
      showDirection();
    }
  }

  void stopDirection() {
    if (directionBottomSheet.isTrue) {
      isShowingDirection.value = false;
      completeRoute.value = false;
      distanceToDest.value = -1;
      currentStoreName.value = "";
      _mapController.setActiveRoute([]);
    }
  }

  void onLocationChanged() {
    currentPosition.listen((location) {
      showDirection();
      checkCurrentLocationOnFloor();
      showShoppingDirections();
      // Determine current position on floor
      if (location.floorPlanId == selectedFloor.value.id) {
        _mapController.setCurrentMarker(location);
      } else {
        _mapController.setCurrentMarker(null);
      }
      // _mapController.moveToScene(location);
    });
  }

  void checkCurrentLocationOnFloor() {
    if (currentPosition.value.floorPlanId != selectedFloor.value.id) {
      final floors = listFloorPlan
          .where((floor) => floor.id == currentPosition.value.floorPlanId);
      if (floors.isNotEmpty) {
        changeSelectedFloor(floors.first);
      }
    }
  }

  List<Location> solveForShortestPath(int beginId, int endId,
      {bool showDirection = true}) {
    // Init graph for finding shortest path from edges
    Graph graph = Graph.from(
      // EdgeHelper.edgesWithCurrentLocation(edges, currentPosition.value).
      edges,
    );
    // Find all shortest paths to endLocationId
    _shortestPathAlgorithm.solve(graph, endId);

    // Get shortest path for current position
    final paths = graph.getShortestPath(beginId);

    if (showDirection) {
      showNearbyDialog(graph, paths, endId);
    }
    return paths;
  }

  void showNearbyDialog(
    Graph graph,
    List<Location> paths,
    int endId,
  ) {
    distanceToDest.value = graph.getTotalDistance(paths, listFloorPlan);

    double minDistance = selectedFloor.value.mapScale == null
        ? 1
        : selectedFloor.value.mapScale! / 100 * 2;
    if (distanceToDest.value < minDistance) {
      if (completeRoute.isFalse) {
        completeRoute.value = true;
        currentStoreName.value =
            getDirectionDetails(endId, null)?["title"] ?? "";

        // nearer than 6 meter
        Get.dialog(DirectionDialog(
          storeName: currentStoreName.value,
        )).then((exit) {
          if (exit) {
            completeRoute.value = false;
          }
        });
      }
    }
  }

  void showDirection() {
    // Incase of edges is empty, end function
    if (edges.isEmpty) return;
    if (shoppingListVisble.value) return;
    if (destPosition.value <= 0) return;
    isShowingDirection.value = true;

    int beginLocationId = currentPosition.value.id!;
    int endLocationId = destPosition.value;

    shortestPath.value = solveForShortestPath(
      beginLocationId,
      endLocationId,
      showDirection: true,
    );

    // Set path on map
    _mapController.setActiveRoute(
      [
        // currentPosition.value,
        ...Graph.getRouteOnFloor(shortestPath, selectedFloor.value.id!)
      ],
    );
  }

  double? calcDistanceBetween(
    Graph graph,
    int beginId,
    int endId,
    List<FloorPlan> floors,
  ) {
    double? distance;
    try {
      // Find all shortest paths to endLocationId
      _shortestPathAlgorithm.solve(graph, endId);

      // Get shortest path for current position
      final paths = graph.getShortestPath(beginId);

      // Total distance
      distance = graph.getTotalDistance(paths, floors);
    } catch (e) {}
    return distance;
  }

  Future<void> setCurrentLocation(Location? location,
      [pressBtn = false]) async {
    if (location == null) return;
    // print("[SetCurrentLocation]");
    // print(location);
    currentPosition.value = location;
  }

  /// Change selected of floor
  Future<void> changeSelectedFloor(FloorPlan? floor) async {
    if (floor?.id == selectedFloor.value.id) return;
    selectedFloor.value = floor!;
  }

  Future<void> searchLocations(String keySearch) async {
    if (keySearch.isEmpty) {
      searchLocationList.clear();
      return;
    }
    int? buildingId = sharedData.building.value.id;
    if (buildingId != null && !isSearchingLocationList.value) {
      isSearchingLocationList.value = true;
      var list = await _locationService.getLocationByKeySearch(
          buildingId.toString(), keySearch);
      if (currentPosition.value.id != null) {
        // Init graph for finding shortest path from edges
        Graph graph = Graph.from(
          // EdgeHelper.edgesWithCurrentLocation(edges, currentPosition.value).
          edges,
        );

        // Find all shortest paths to endLocationId
        list.forEach((e) {
          e.distanceTo = calcDistanceBetween(
            graph,
            currentPosition.value.id!,
            e.id!,
            listFloorPlan,
          );
        });
      }
      searchLocationList.value = list;
      Timer(Duration(seconds: 1), () => isSearchingLocationList.value = false);
    }
  }

  /// Get list Coupon from api
  void getCoupons(int? floorPlanId) async {
    if (floorPlanId == null) return;
    listCoupon.value = await _couponService.getCounponsByFloorPlanId(
      floorPlanId,
    );
  }

  /// Get list FloorPlan from api by buildingID
  Future<List<int>> getFloorPlan() async {
    listFloorPlan.value =
        await _floorPlanService.getFloorPlans(sharedData.building.value.id!);
    selectedFloor.value = listFloorPlan[0];
    return listFloorPlan.map((element) => element.id!).toList();
  }

  /// On Selected floor changed
  void onSelectedFloorChange() {
    selectedFloor.listen((floor) {
      onShoppingListChange();
      getCoupons(floor.id);
      _mapController.loadLocationsOnMap(
        locationsOnMap.where((e) => e.floorPlanId == floor.id).toList(),
      );
      _pdrConfig?.rotationAngle = floor.rotationAngle!;
      _pdrConfig?.mapScale = floor.mapScale!;
      _bleConfig?.mapScale = floor.mapScale!;
    });
  }

  /// On Shopping List Change
  void onShoppingListChange() {
    if (sharedData.startShopping.isFalse) return;
    // Set shopping stores
    _mapController.setShoppingPoints(Graph.getShoppingPoints(
      listStoreShopping,
      selectedFloor.value.id!,
    ));

    // Set shopping routes
    setShoppingRoutes(listShoppingRoutes);
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
      edges.value = EdgeHelper.splitToSegments(
        await _edgeService.getByBuildingId(buildingId),
        selectedFloor.value.mapScale ?? 15,
      );
    }
  }

  Future<void> loadPlaceOnBuilding() async {
    locationsOnMap.value = await _locationService.getLocationOnBuilding(
      sharedData.building.value.id!,
    );
    _mapController.loadLocationsOnMap(
      locationsOnMap
          .where((e) => e.floorPlanId == selectedFloor.value.id)
          .toList(),
    );
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
    if (shoppingListVisble.isFalse && isShowingDirection.isTrue) {
      int index = -1;
      final paths = shortestPath.map((e) => e).toList();
      Timer.periodic(Duration(milliseconds: 120), (timer) {
        if (isShowingDirection.isTrue) {
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

  final testRoute = <Location>[].obs;
  int currentRouteIndex = 0;
  void testGoingShoppingRoutes() {
    // final shoppings = listShoppingRoutes.map((e) => e).toList();
    testRoute.value = listShoppingRoutes[0];
    if (currentRouteIndex < listShoppingRoutes.length) {
      int index = -1;
      final paths = testRoute.map((e) => e).toList();
      Timer.periodic(Duration(milliseconds: 120), (timer) {
        if (index >= paths.length - 1) {
          timer.cancel();
        } else {
          setCurrentLocation(paths[++index]);
        }
      });
    }
    // currentRouteIndex++;
  }
}
