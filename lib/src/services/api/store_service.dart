import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin IStoreService {
  Future<Store> getStoreById(int id);
}

class StoreService extends BaseService<Store> implements IStoreService {
  @override
  String endpoint() {
    return Endpoints.stores;
  }

  @override
  Store fromJson(Map<String, dynamic> json) {
    return Store.fromJson(json);
  }

  @override
  Future<Store> getStoreById(int id) {
    return getByIdBase(id);
  }
}
