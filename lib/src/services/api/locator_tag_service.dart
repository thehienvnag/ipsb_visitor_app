import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/locator_tag.dart';

import 'package:ipsb_visitor_app/src/services/api/base_service.dart';

mixin ILocatorTagService {
  Future<List<LocatorTag>> getByBuildingId(int buildingId);
}

class LocatorTagService extends BaseService<LocatorTag>
    implements ILocatorTagService {
  @override
  String endpoint() {
    return Endpoints.locatorTag;
  }

  @override
  LocatorTag fromJson(Map<String, dynamic> json) {
    return LocatorTag.fromJson(json);
  }

  @override
  Future<List<LocatorTag>> getByBuildingId(int buildingId) {
    return getAllBase({
      "buildingId": buildingId.toString(),
      "status": "Active",
    });
  }
}
