import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/home_page_final/controllers/home_page_final_controller.dart';

class HomePageFinalBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<HomePageFinalController>(() => HomePageFinalController());
  }
}
