import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/building.dart';
import 'package:ipsb_visitor_app/src/services/api/base_service.dart';

mixin IBuildingService {
  Future<Building?> getBuildingById(int id);
  Future<List<Building>> getBuildings([double? lat, double? lng]);
  Future<List<Building>> searchBuildings([
    String? search,
    double? lat,
    double? lng,
  ]);
  Future<Building?> getByLocatorTagUuid(String uuid);
  Future<Building?> findCurrentBuilding(double lat, double lng);
}

class BuildingService extends BaseService<Building>
    implements IBuildingService {
  @override
  String endpoint() {
    return Endpoints.buildings;
  }

  @override
  Building fromJson(Map<String, dynamic> json) {
    return Building.fromJson(json);
  }

  @override
  Future<Building?> getBuildingById(int id) async {
    return getByIdBase(id);
  }

  @override
  Future<List<Building>> getBuildings([double? lat, double? lng]) {
    var params = {"pageSize": "5"};
    if (lat != null) {
      params.putIfAbsent("lat", () => lat.toString());
    }
    if (lng != null) {
      params.putIfAbsent("lng", () => lng.toString());
    }
    return getAllBase(params);
  }

  @override
  Future<List<Building>> searchBuildings([
    String? search,
    double? lat,
    double? lng,
  ]) {
    final params = {
      "pageSize": "5",
      "status": "Active",
    };
    if (search != null) {
      params.putIfAbsent("name", () => search);
      params.putIfAbsent("isAll", () => "true");
    }
    if (lat != null && lng != null) {
      params.putIfAbsent("lat", () => lat.toString());
      params.putIfAbsent("lng", () => lng.toString());
    }
    return getAllBase(params);
  }

  @override
  Future<Building?> getByLocatorTagUuid(String uuid) {
    return getByEndpoint(uuid);
  }

  @override
  Future<Building?> findCurrentBuilding(double lat, double lng) async {
    final list = await getAllBase({
      "lat": lat.toString(),
      "lng": lng.toString(),
      "pageSize": "1",
      "findCurrentBuilding": "true",
      "status": "Active",
    });
    if (list.isNotEmpty) {
      return list.first;
    }
  }
}
