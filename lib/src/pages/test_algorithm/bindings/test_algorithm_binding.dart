import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/test_algorithm/controllers/test_algorithm_controller.dart';

class TestAlgorithmBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<TestAlgorithmController>(() => TestAlgorithmController());
  }
}
