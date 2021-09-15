import 'package:get/get.dart';
import 'package:com.ipsb.visitor_app/src/pages/building_store_list/controllers/building_store_controller.dart';

class BuildingStoreBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Building stores controller
    Get.lazyPut<BuildingStoreController>(() => BuildingStoreController());
  }
}
