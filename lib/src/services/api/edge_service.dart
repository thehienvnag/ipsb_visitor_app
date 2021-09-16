import 'package:visitor_app/src/common/endpoints.dart';
import 'package:visitor_app/src/models/edge.dart';
import 'package:visitor_app/src/services/api/base_service.dart';

mixin IEdgeService {
  /// Get list of edges from a floor plan
  Future<List<Edge>> getByFloorPlanId(int floorPlanId);

  /// Get all edges from n floor [floors]
  Future<List<Edge>> getEdgesFromFloors(List<int> floors);

  /// Get all edges from n floor [floors]
  Future<List<Edge>> getAll();

  /// Get all edges from building
  Future<List<Edge>> getByBuildingId(int buildingId);
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
  Future<List<Edge>> getEdgesFromFloors(List<int> floorIds) async {
    var edges = await Future.wait(
      floorIds.map((id) => getByFloorPlanId(id)),
    );
    return edges.expand((edge) => edge).toList();
  }

  @override
  Future<List<Edge>> getAll() async {
    return getAllBase({
      "isAll": true.toString(),
    });
  }

  @override
  Future<List<Edge>> getByBuildingId(int buildingId) {
    return getAllBase({
      "isAll": true.toString(),
      "buildingId": buildingId.toString(),
    });
  }
}
