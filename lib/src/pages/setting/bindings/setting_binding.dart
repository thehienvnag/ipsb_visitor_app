import 'package:get/get.dart';
import 'package:visitor_app/src/pages/setting/controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Setting controller
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
