import 'package:get/get.dart';
import 'package:com.ipsb.visitor_app/src/pages/building_details/controllers/building_detail_controller.dart';

class BuildingDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Building Details controller
    Get.lazyPut<BuildingDetailController>(() => BuildingDetailController());
  }
}
