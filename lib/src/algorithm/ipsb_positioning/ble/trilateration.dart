import 'dart:async';

import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/base_ble_action.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/managers/beacon_manager.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/filters/mean_filter.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/beacon.dart';

import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/ble_positioning.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/trilateration/lsq_trilateration.dart';

abstract class BaseTrilateration extends BaseBleAction {
  Location2d? resolveLocation();
  void stop();
}

class Trilateration extends BaseTrilateration {
  /// Current floor id stream
  final Stream<int> currentFloorEvents;

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
    currentFloorEvents.listen((floorId) {
      _currentFloor = floorId;
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
                  _config.environmentFactor,
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
  Location2d? resolveLocation() {
    if (locationsCalculated.isNotEmpty) {
      final location = MeanFilter.filter(locationsCalculated);
      locationsCalculated.clear();
      return location;
    }
  }

  List<Beacon> findByFloorId(List<Beacon> list, int floorId) =>
      list.where((e) => e.location!.floorPlanId == floorId).toList();

  @override
  void stop() {
    _timer?.cancel();
  }
}
