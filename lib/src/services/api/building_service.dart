import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/building.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin IBuildingService {
  Future<Building?> getBuildingById(int id);
  Future<List<Building>> getBuildings();
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
  Future<List<Building>> getBuildings() {
    return getAllBase({"pageSize": "5"});
  }
}
