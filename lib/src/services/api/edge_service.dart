import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/edge.dart';
import 'package:ipsb_visitor_app/src/services/api/base_service.dart';
import 'package:ipsb_visitor_app/src/services/storage/hive_storage.dart';

mixin IEdgeService {
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
  Future<List<Edge>> getByBuildingId(int buildingId) {
    final query = {
      "isAll": true.toString(),
      "buildingId": buildingId.toString(),
    };
    final callback = (ifModifiedSince) => getCacheResponse(
          query,
          ifModifiedSince: ifModifiedSince,
        );
    final String key = getCacheKey(query);
    return HiveStorage.useStorageList<Edge>(
      apiCallback: callback,
      key: key,
      storageBox: StorageConstants.edgeDataBox,
    );
  }
}
