import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';
import 'package:indoor_positioning_visitor/src/services/api/base_service.dart';

mixin ILocationService {
  Future<Paging> getAll(int locationTypeId);
}

class LocationService extends BaseService implements ILocationService {
  @override
  String endpoint() {
    return Endpoints.locations;
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return Location.fromJson(json);
  }

  @override
  Future<Paging> getAll(int locationTypeId) {
    return getAllBase({
      'locationTypeId': locationTypeId,
      'isAll': true.toString(),
    });
  }
}
