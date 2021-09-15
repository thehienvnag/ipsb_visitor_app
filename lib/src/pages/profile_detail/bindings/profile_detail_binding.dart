import 'package:get/get.dart';
import 'package:com.ipsb.visitor_app/src/pages/profile_detail/controllers/profile_detail_controller.dart';

class ProfileDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Profile detail controller
    Get.lazyPut<ProfileDetailController>(() => ProfileDetailController());
  }
}
