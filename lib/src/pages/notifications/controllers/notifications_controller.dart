import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/notification.dart';
import 'package:ipsb_visitor_app/src/services/api/notification_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

class NotificationsController extends GetxController {
  INotificationService _service = Get.find();
  final notifications = <Notifications>[].obs;
  final loading = false.obs;
  SharedStates sharedStates = Get.find();

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() async {
    loading.value = true;
    notifications.value = await _service
        .getNotificationsByAccountId(AuthServices.userLoggedIn.value.id!);
    notifications.sort((a, b) => -a.date!.compareTo(b.date!));
    loading.value = false;
  }

  void updateNotifications(int id, String status) async {
    await _service.updateNotification(id, {"id" : id.toString(), "status": status});
    sharedStates.unreadNotification.value =
        await _service.countNotification({"status": Constants.unread});
  }
}
