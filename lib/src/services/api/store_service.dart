import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';


mixin IStoreService {
  Future<Paging<Store>> getStores(int buildingId);
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
  Future<Paging<Store>> getStores(int buildingId) {
    return getPagingBase({
      'buildingId': buildingId.toString(),
    });
  }

}
