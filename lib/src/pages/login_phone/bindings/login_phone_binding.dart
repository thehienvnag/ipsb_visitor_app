import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/login_phone/controllers/login_phone_controller.dart';

class LoginPhoneBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Login by phone controller
    Get.lazyPut<LoginPhoneController>(() => LoginPhoneController());
  }
}
