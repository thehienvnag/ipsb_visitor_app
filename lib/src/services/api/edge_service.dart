import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/edge.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin IEdgeService {
  /// Get list of edges from a floor plan
  Future<List<Edge>> getByFloorPlanId(int floorPlanId);

  /// Get all edges from n floor [floors]
  Future<List<Edge>> getEdges(List<int> floors);
}

class EdgeService extends BaseService<Edge> implements IEdgeService {
  @override
  String endpoint() {
    return Endpoints.edges;
  }

  @override
  Edge fromJson(Map<String, dynamic> json) {
    return Edge.fromJson(json);
  }

  @override
  Future<List<Edge>> getByFloorPlanId(int floorPlanId) async {
    return await getAllBase({
      'isAll': true.toString(),
      'floorPlanId': floorPlanId.toString(),
    });
  }

  @override
  Future<List<Edge>> getEdges(List<int> floorIds) async {
    var edges = await Future.wait(
      floorIds.map((id) => getByFloorPlanId(id)),
    );
    return edges.expand((edge) => edge).toList();
  }
}
