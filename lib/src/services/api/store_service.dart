import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/paging.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/services/api/base_service.dart';

mixin IStoreService {
  Future<Store?> getStoreById(int id);
  Future<Paging<Store>> getStores(String searchName, int floorPlanId);
  Future<Paging<Store>> getStoresByBuilding(
    int buildingId, {
    bool random = false,
  });
  Future<List<Store>> searchStore(
    String search, {
    double? lat,
    double? lng,
  });
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
  Future<Store?> getStoreById(int id) {
    return getByIdBase(id);
  }

  Future<List<Store>> searchStore(
    String search, {
    double? lat,
    double? lng,
  }) async {
    final params = {
      "name": search.toString(),
      "pageSize": "5",
    };
    if (lat != null && lng != null) {
      params.putIfAbsent("lat", () => lat.toString());
      params.putIfAbsent("lng", () => lng.toString());
    }
    return getAllBase(params);
  }

  Future<Paging<Store>> getStores(String searchName, int floorPlanId) async {
    return getPagingBase({
      "name": searchName.toString(),
      "floorPlanId": floorPlanId.toString(),
    });
  }

  @override
  Future<Paging<Store>> getStoresByBuilding(
    int buildingId, {
    bool random = false,
  }) {
    final params = {
      "buildingId": buildingId.toString(),
      "status": 'Active',
    };

    if (random) {
      params.putIfAbsent("random", () => "true");
    }
    return getPagingBase(params);
  }
}
