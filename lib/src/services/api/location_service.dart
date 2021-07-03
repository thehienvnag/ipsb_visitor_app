import 'package:indoor_positioning_visitor/src/common/constants.dart';
import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin ILocationService {
  /// Get all stairs and lifts location from a [floorPlanId]
  Future<List<Location>> getStairsAndLifts(int floorPlanId);

  /// Get locations from a [floorPlanId] based on [locationType]
  Future<List<Location>> getLocationsByType(int locationType, int floorPlanId);

  Future<List<Location>> getLocationOnFloor(int floorPlanId);

  Future<List<Location>> getLocationOnFloorWithLocationTypeId(int floorPlanId,
      [int locationTypeId = 2]);

  Future<Location?> getLocationById(int id);
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
    });
  }

  @override
  Future<List<Location>> getLocationOnFloor(int floorPlanId,
      [int locationTypeId = 2]) async {
    return await getAllBase({
      'isAll': true.toString(),
      'floorPlanId': floorPlanId.toString(),
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
    });
  }
}
