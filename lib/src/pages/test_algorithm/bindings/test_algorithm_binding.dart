import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/test_algorithm/controllers/test_algorithm_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/image_view/image_view_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/indoor_map/indoor_map_controller.dart';

class TestAlgorithmBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<ImageViewController>(() => ImageViewController());
    Get.lazyPut<IndoorMapController>(() => IndoorMapController());
    Get.put<TestAlgorithmController>(TestAlgorithmController());
  }
}
