import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/building_details/controllers/building_detail_controller.dart';


class BuildingDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Building Details controller
    Get.lazyPut<BuildingDetailController>(() => BuildingDetailController());
  }
}