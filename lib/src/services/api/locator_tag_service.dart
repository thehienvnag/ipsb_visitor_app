import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/locator_tag.dart';

import 'package:ipsb_visitor_app/src/services/api/base_service.dart';
import 'package:ipsb_visitor_app/src/services/storage/hive_storage.dart';

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
    final query = {
      "buildingId": buildingId.toString(),
      "isAll": "true",
      "status": "Active",
    };

    final callback = (ifModifiedSince) => getCacheResponse(
          query,
          ifModifiedSince: ifModifiedSince,
        );
    final String key = getCacheKey(query);
    return HiveStorage.useStorageList<LocatorTag>(
      apiCallback: callback,
      key: key,
      storageBox: StorageConstants.locatorTagDataBox,
    );
  }
}
