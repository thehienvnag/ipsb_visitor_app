import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';
import 'package:ipsb_visitor_app/src/services/api/base_service.dart';
import 'package:ipsb_visitor_app/src/services/storage/hive_storage.dart';

mixin ILocationService {
  Future<List<Location>> getLocationOnBuilding(int buildingId);

  Future<List<Location>> getLocationByKeySearch(
      String buildingId, String keySearch);
}

class LocationService extends BaseService<Location>
    implements ILocationService {
  @override
  String endpoint() {
    return Endpoints.locations;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Location.fromJson(json);
  }

  @override
  Future<List<Location>> getLocationOnBuilding(int buildingId) async {
    final query = {
      'isAll': true.toString(),
      'buildingId': buildingId.toString(),
      'notLocationTypeIds': ["2", "5"],
      'status': "Active"
    };
    final String key = getCacheKey(query);
    final callback = (ifModifiedSince) => getCacheResponse(
          query,
          ifModifiedSince: ifModifiedSince,
        );
    return HiveStorage.useStorageList<Location>(
      apiCallback: callback,
      key: key,
      storageBox: StorageConstants.locationDataBox,
    );
  }

  @override
  Future<List<Location>> getLocationByKeySearch(
      String buildingId, String keySearch) async {
    final params = {
      "isAll": "true",
      "searchKey": keySearch,
      "buildingId": buildingId,
      "notLocationTypeIds": ["2", "5"], //Ignore Road & iBeacon
      'status': "Active",
    };
    return getAllBase(params);
  }
}
