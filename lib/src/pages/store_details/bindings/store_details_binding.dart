import 'package:get/get.dart';

import 'package:indoor_positioning_visitor/src/pages/store_details/controllers/store_details_controller.dart';

class StoreDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<StoreDetailsController>(() => StoreDetailsController());
  }
}
