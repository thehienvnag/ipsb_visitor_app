import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/pages/profile_detail/controllers/profile_detail_controller.dart';

class ProfileDetailBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Profile detail controller
    Get.lazyPut<ProfileDetailController>(() => ProfileDetailController());
  }
}
