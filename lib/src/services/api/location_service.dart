import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';
import 'package:ipsb_visitor_app/src/services/api/base_service.dart';

mixin ILocationService {
  /// Get all stairs and lifts location from a [floorPlanId]
  Future<List<Location>> getStairsAndLifts(int floorPlanId);

  /// Get locations from a [floorPlanId] based on [locationType]
  Future<List<Location>> getLocationsByType(int locationType, int floorPlanId);

  Future<List<Location>> getLocationOnBuilding(int buildingId);

  Future<List<Location>> getLocationOnFloorWithLocationTypeId(int buildingId);

  Future<Location?> getLocationById(int id);

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
  Future<List<Location>> getStairsAndLifts(int floorPlanId) async {
    var stairs = getLocationsByType(Constants.locationTypeStair, floorPlanId);
    var lifts = getLocationsByType(Constants.locationTypeLift, floorPlanId);
    var result = await Future.wait([stairs, lifts]);
    return result.expand((element) => element).toList();
  }

  @override
  Future<List<Location>> getLocationsByType(
      int locationType, int floorPlanId) async {
    return await getAllBase({
      'isAll': true.toString(),
      'locationTypeId': locationType.toString(),
      'floorPlanId': floorPlanId.toString(),
      'status': "Active",
    });
  }

  @override
  Future<List<Location>> getLocationOnBuilding(int buildingId) async {
    return await getAllBase({
      'isAll': true.toString(),
      'buildingId': buildingId.toString(),
      'notLocationTypeIds': ["2", "5"],
      'status': "Active"
    });
  }

  @override
  Future<Location?> getLocationById(int id) async {
    return getByIdBase(id);
  }

  @override
  Future<List<Location>> getLocationOnFloorWithLocationTypeId(int floorPlanId,
      [int locationTypeId = 2]) async {
    return await getAllBase({
      'isAll': true.toString(),
      'floorPlanId': floorPlanId.toString(),
      'locationTypeId': locationTypeId.toString(),
      'status': "Active",
    });
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
