import 'package:get/get.dart';

import 'package:com.ipsb.visitor_app/src/pages/store_details/controllers/store_details_controller.dart';

class StoreDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<StoreDetailsController>(() => StoreDetailsController(),
        fenix: true);
  }
}
