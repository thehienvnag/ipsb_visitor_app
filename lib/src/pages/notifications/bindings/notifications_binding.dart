import 'package:get/get.dart';

import 'package:indoor_positioning_visitor/src/pages/notifications/controllers/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    // Bind Home controller
    Get.lazyPut<NotificationsController>(() => NotificationsController());
  }
}
