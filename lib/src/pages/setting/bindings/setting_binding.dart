import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/setting/controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Setting controller
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
