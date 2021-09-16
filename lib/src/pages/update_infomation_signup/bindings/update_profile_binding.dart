import 'package:get/get.dart';
import 'package:visitor_app/src/pages/update_infomation_signup/controllers/update_profile_controller.dart';

class UpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Update profile controller
    Get.lazyPut<UpdateProfileController>(() => UpdateProfileController());
  }
}
