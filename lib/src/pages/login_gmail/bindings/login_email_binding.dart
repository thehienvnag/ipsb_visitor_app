import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/pages/login_gmail/controllers/login_gmail_controller.dart';

class LoginEmailBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Login with email controller
    Get.lazyPut<LoginEmailController>(() => LoginEmailController());
  }
}
