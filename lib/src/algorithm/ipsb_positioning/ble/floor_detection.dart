import 'dart:async';

import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/managers/beacon_manager.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/beacon.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/ble_positioning.dart';

import 'base_ble_action.dart';

abstract class BaseFloorDetection extends BaseBleAction {
  /// stop
  void stop();
}

class FloorDetection extends BaseFloorDetection {
  /// On floor changed callback
  final void Function(int) onChange;

  /// Ble Config
  late final BlePositioningConfig _config;

  Timer? _timer;

  FloorDetection({
    required this.onChange,
  });

  late final IBeaconManager _beaconManager;

  int? _currentFloor;
  int? _willUpdateFloor;
  int _updateFloorCounter = 0;
  Map<int, int> floorDetectCounter = {};

  @override
  void init(BlePositioningConfig config) {
    _config = config;
    _beaconManager = BeaconManager(beacons: _config.beacons);
    periodicFloorDetection();
  }

  @override
  void stop() {
    _timer?.cancel();
  }

  @override
  void handleScanData(String uuid, int rssi, [int? floorId]) {
    _beaconManager.addBeaconFound(uuid, rssi);
  }

  /// Perform floor detection periodically
  void periodicFloorDetection() {
    const interval = const Duration(seconds: 3);

    _timer = Timer.periodic(interval, (timer) {
      floorDetection();
    });
  }

  void floorDetection() {
    final beacons = _beaconManager.getUsableBeacons();
    // final beacons = _beaconManager.getFloorUsableBeacons();
    final beaconMap = getGroupBeacons(beacons);
    // final floorId = getFloorDetectionResult(beaconMap);
    final floorId = filterFloorNoise(
      getFloorDetectionResult(beaconMap),
      // enabled: false,
    );
    if (floorId != null) {
      _currentFloor = floorId;
      _willUpdateFloor = null;
      _updateFloorCounter = 0;
      onChange(floorId);
    }
  }

  int? filterFloorNoise(int? floorId, {bool enabled = true}) {
    if (!enabled) return floorId;
    if (floorId == _currentFloor) return null;
    if (floorId != null) {
      if (_currentFloor == null) return floorId;
      if (_currentFloor != _willUpdateFloor) {
        _willUpdateFloor = floorId;
        if (_willUpdateFloor == null || _willUpdateFloor == floorId) {
          _updateFloorCounter += 1;
        } else {
          _updateFloorCounter = 0;
        }
        if (_updateFloorCounter >= 3) {
          return floorId;
        }
      }
    }
  }

  Map<int, List<Beacon>> getGroupBeacons(List<Beacon> beacons) {
    Map<int, List<Beacon>> beaconMap = {};
    List<int> beaconGroups = _beaconManager.getBeaconGroups();
    beaconGroups.forEach((e) {
      beaconMap.putIfAbsent(e, () => []);
    });
    beacons.forEach((e) {
      if (e.beaconGroupId != null) {
        final group = beaconMap.putIfAbsent(e.beaconGroupId!, () => [e]);
        if (!group.any((beaconInGroup) => beaconInGroup.id == e.id)) {
          group.add(e);
        }
      }
    });
    beacons.forEach((e) {
      if (beaconMap.containsKey(e.id)) {
        beaconMap[e.id]?.add(e);
      }
    });
    return beaconMap;
  }

  int? getFloorDetectionResult(
    Map<int, List<Beacon>> beaconMap,
  ) {
    Beacon? nearestBeacon;
    if (beaconMap.isNotEmpty) {
      beaconMap.values.forEach((listBeacon) {
        final nearestInGroupBeacon = getNearestBeacon(listBeacon);
        if (nearestInGroupBeacon != null) {
          if (nearestBeacon == null) {
            nearestBeacon = nearestInGroupBeacon;
          } else {
            if (nearestInGroupBeacon.distance! < nearestBeacon!.distance!) {
              nearestBeacon = nearestInGroupBeacon;
            }
          }
        }
      });
      if (nearestBeacon != null) {
        return nearestBeacon!.location!.floorPlanId;
      }
    }
  }

  Beacon? getNearestBeacon(List<Beacon> list) {
    double? distance;
    Beacon? result;
    list.forEach((e) {
      if (distance == null) {
        distance = e.getDistanceAvg();
        if (distance != null) {
          e.distance = distance;
          result = e;
        }
      } else {
        var elementDistance = e.getDistanceAvg();
        if (elementDistance != null && elementDistance < distance!) {
          distance = elementDistance;
          e.distance = distance;
          result = e;
        }
      }
    });
    return result;
  }
}
