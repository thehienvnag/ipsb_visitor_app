import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/edge.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin IEdgeService {
  /// Get list of edges from a floor plan
  Future<List<Edge>> getAll(int floorPlanId);
}

class EdgeService extends BaseService<Edge> implements IEdgeService {
  @override
  String endpoint() {
    return Endpoints.edges;
  }

  @override
  dynamic fromJson(Map<String, dynamic> json) {
    return Edge.fromJson(json);
  }

  @override
  Future<List<Edge>> getAll(int floorPlanId) async {
    return await getAllBase({
      'isAll': true.toString(),
      'floorPlanId': floorPlanId.toString(),
    });
  }
}
