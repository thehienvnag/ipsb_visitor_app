import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/floor_plan.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';


mixin IFloorPlanService {
  Future<Paging<FloorPlan>> getFloorPlans(int buildingId);
}

class FloorPlanService extends BaseService<FloorPlan> implements IFloorPlanService {
  @override
  String endpoint() {
    return Endpoints.floorPlans;
  }

  @override
  FloorPlan fromJson(Map<String, dynamic> json) {
    return FloorPlan.fromJson(json);
  }

  @override
  Future<Paging<FloorPlan>> getFloorPlans(int buildingId) async {
    return getPagingBase({
      "buildingId": buildingId.toString(),
    });
  }

}
