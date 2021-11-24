import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:ipsb_visitor_app/src/services/api/base_service.dart';
import 'package:ipsb_visitor_app/src/services/storage/hive_storage.dart';

mixin IFloorPlanService {
  Future<List<FloorPlan>> getFloorPlans(int buildingId);
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
  Future<List<FloorPlan>> getFloorPlans(int buildingId) async {
    final query = {
      "buildingId": buildingId.toString(),
      "isAll": true.toString(),
    };
    final callback = (ifModifiedSince) => getCacheResponse(
          query,
          ifModifiedSince: ifModifiedSince,
        );
    final String key = getCacheKey(query);
    return HiveStorage.useStorageList<FloorPlan>(
      apiCallback: callback,
      key: key,
      storageBox: StorageConstants.floorPlanDataBox,
    );
  }
}
