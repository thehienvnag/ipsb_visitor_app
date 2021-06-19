import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/shortest_path.dart';
import 'package:indoor_positioning_visitor/src/data/api_helper.dart';
import 'package:indoor_positioning_visitor/src/services/api/edge_service.dart';

class AppInit {
  static void init() {
    // Use for calling api
    Get.lazyPut<IApiHelper>(() => ApiHelper());
    // Get image from file system
    Get.lazyPut<ImagePicker>(() => ImagePicker());
    // Find shortest path algorithm
    Get.lazyPut<IShortestPath>(() => ShortestPath());
    // Calling api at edge service
    Get.lazyPut<IEdgeService>(() => EdgeService());
  }
}
