import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/edge.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin IEdgeService {
  Future<Paging> getAll(int floorPlanId);
}

class EdgeService extends BaseService implements IEdgeService {
  @override
  String endpoint() {
    return Endpoints.edges;
  }

  @override
  dynamic fromJson(Map<String, dynamic> json) {
    return Edge.fromJson(json);
  }

  @override
  Future<Paging> getAll(int floorPlanId) async {
    return getAllBase({
      'isAll': true.toString(),
      'floorPlanId': floorPlanId.toString(),
    });
  }
}
