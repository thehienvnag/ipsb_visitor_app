import 'dart:async';

import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/base_ble_action.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/filters/mean_filter.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/beacon.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/ble_positioning.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/trilateration/lsq_trilateration.dart';

import 'managers/beacon_manager.dart';

abstract class BaseTrilateration extends BaseBleAction {
  Location2d? resolveLocation(int floorId, bool removeOldLocation);
  void removeOldLocations();
  void stop();
}

class Trilateration extends BaseTrilateration {
  /// Current floor id stream
  final Stream<Map<int, bool>> currentFloorEvents;

  /// Ble Config
  late final BlePositioningConfig _config;

  late final IBeaconManager _beaconManager;

  final lsqTrilateration = LSQTrilateration();

  List<Location2d> locationsCalculated = [];

  Trilateration({
    required this.currentFloorEvents,
  });

  /// Current floor
  int? _currentFloor;

  /// Timer
  Timer? _timer;

  @override
  void init(config) {
    _config = config;
    _beaconManager = BeaconManager(beacons: _config.beacons);
    currentFloorEvents.listen((res) {
      _currentFloor = res.keys.first;
    });
    periodicHandleLocation();
  }

  @override
  void handleScanData(String uuid, int rssi) {
    _beaconManager.addBeaconFound(uuid, rssi);
  }

  void periodicHandleLocation() {
    const interval = const Duration(milliseconds: 800);
    _timer = Timer.periodic(interval, (timer) {
      handleLocation();
    });
  }

  void handleLocation() {
    if (_currentFloor == null) return; //If no floor is detected
    var beacons = _beaconManager.getUsableBeacons(_currentFloor);
    if (beacons.length >= 3) {
      final locations = beacons
          .map((e) => Location2d(
                y: e.location!.y,
                x: e.location!.x,
                floorPlanId: e.location!.floorPlanId,
                distance: e.getDistance(
                  _config.mapScale,
                ),
              ))
          .where((e) => e.distance != null)
          .toList();
      if (locations.length >= 3) {
        final location = lsqTrilateration.solve(locations);
        locationsCalculated.add(location);
      }
    }
  }

  @override
  Location2d? resolveLocation(int floorId, bool removeOldLocation) {
    final locations = locationsCalculated.where((e) => !e.isOld());
    if (locations.isNotEmpty) {
      final location = MeanFilter.filter(locations);
      if (removeOldLocation) {
        locationsCalculated.clear();
      }
      if (location.floorPlanId == floorId) {
        return location;
      }
    }
  }

  List<Beacon> findByFloorId(List<Beacon> list, int floorId) =>
      list.where((e) => e.location!.floorPlanId == floorId).toList();

  @override
  void stop() {
    _timer?.cancel();
  }

  @override
  void removeOldLocations() {
    locationsCalculated.removeWhere((e) => e.isOld());
  }
}
