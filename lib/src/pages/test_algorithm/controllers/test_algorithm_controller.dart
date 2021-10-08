import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/services/api/location_service.dart';
import 'package:ipsb_visitor_app/src/widgets/indoor_map/indoor_map_controller.dart';

class TestAlgorithmController extends GetxController {
  /// Inject EdgeService
  // IEdgeService _edgeService = Get.find();

  // /// Inject LocationService
  // ILocationService _locationService = Get.find();

  // /// Find shortest path algorithm
  // IShortestPath _shortestPath = Get.find();

  // /// Destination source id
  // var destSourceId = 35.obs;

  // /// From source id
  // var fromSourceId = 30.obs;

  // /// Get edges from API
  // Future<void> getEdges() async {
  //   // Get edges from API
  //   var edges = await _edgeService.getEdges([2, 3, 4]);

  //   // Build graph for Dijiktra algorithm
  //   var graph = Graph.from(edges);

  //   // Get shortest path from destination source id
  //   _shortestPath.getShortestPath(
  //     graph,
  //     47,
  //   );

  //   // Retrieve path from depart source id
  //   print(graph.getPathFrom(30));
  //   // print(graphFromDest.value.getPathFrom(35));
  // }

  // /// Get stairs and lift on a floor
  // Future<void> getStairsAndLifts() async {
  //   // Get stairs and lifts from API
  //   var locations = await _locationService.getStairsAndLifts(2);
  //   print(locations);
  // }

  /// IndoorMapController
  IndoorMapController _mapController = Get.find();

  @override
  void onInit() {
    super.onInit();
    // _mapController.loadLocationsOnMap([]);
    // _mapController.setCurrentMarker(null);
    // setPathsOnMap();
    setLocationOnFloor();
  }

  ILocationService _locationService = Get.find();
  Future<void> setPathsOnMap() async {
    final locations = await _locationService.getLocationsByType(2, 12);
    _mapController.setPathOnMap(locations);
  }

  Future<void> setLocationOnFloor() async {
    final locations = await _locationService.getLocationOnFloor(12);
    _mapController.loadLocationsOnMap(locations);
  }
}
