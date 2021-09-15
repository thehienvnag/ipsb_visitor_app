import 'package:com.ipsb.visitor_app/src/common/endpoints.dart';
import 'package:com.ipsb.visitor_app/src/models/floor_plan.dart';
import 'package:com.ipsb.visitor_app/src/models/paging.dart';
import 'package:com.ipsb.visitor_app/src/services/api/base_service.dart';

mixin IFloorPlanService {
  Future<Paging<FloorPlan>> getFloorPlans(int buildingId);
}

class FloorPlanService extends BaseService<FloorPlan>
    implements IFloorPlanService {
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
      "isAll": true.toString(),
    });
  }
}
