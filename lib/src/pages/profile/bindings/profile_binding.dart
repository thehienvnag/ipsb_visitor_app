import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/profile/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Profile controller
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
