import 'package:get/get.dart';
import 'package:com.ipsb.visitor_app/src/pages/test_algorithm/controllers/test_algorithm_controller.dart';
import 'package:com.ipsb.visitor_app/src/widgets/image_view/image_view_controller.dart';
import 'package:com.ipsb.visitor_app/src/widgets/indoor_map/indoor_map_controller.dart';

class TestAlgorithmBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<ImageViewController>(() => ImageViewController());
    Get.lazyPut<IndoorMapController>(() => IndoorMapController());
    Get.put<TestAlgorithmController>(TestAlgorithmController());
  }
}
