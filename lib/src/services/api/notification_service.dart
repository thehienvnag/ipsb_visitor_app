import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/notification.dart';
import 'package:ipsb_visitor_app/src/services/api/base_service.dart';

mixin INotificationService {
  Future<List<Notifications>> getNotificationsByAccountId(int id);
  Future<int> countNotification(Map<String, dynamic> data);
  Future<bool> updateNotification(int id, Map<String, dynamic> data);
  Future<bool> deleteNotification(int id);
}

class NotificationService extends BaseService<Notifications>
    implements INotificationService {
  @override
  String endpoint() {
    return Endpoints.notifications;
  }

  @override
  Notifications fromJson(Map<String, dynamic> json) {
    return Notifications.fromJson(json);
  }

  @override
  Future<List<Notifications>> getNotificationsByAccountId(int id) async {
    return getAllBase({"accountId" : id.toString(), "isAll" : "true"});
  }

  @override
  Future<int> countNotification(Map<String, dynamic> data) {
    return countBase(data);
  }

  @override
  Future<bool> deleteNotification(int id) {
    return deleteBase(id);
  }

  @override
  Future<bool> updateNotification(int id, Map<String, dynamic> data) {
    return putBase(id, data);
  }


}
