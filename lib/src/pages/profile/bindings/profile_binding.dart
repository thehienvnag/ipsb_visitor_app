import 'package:get/get.dart';
import 'package:com.ipsb.visitor_app/src/pages/profile/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Profile controller
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
