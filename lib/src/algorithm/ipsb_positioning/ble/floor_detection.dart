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
      floorDetectionV2();
      // floorDetection();
      // testFloorDetection();
      // testFloorDetection2();
    });
  }

  void floorDetectionV2() {
    final beacons = _beaconManager.getUsableBeacons();
    // final beacons = _beaconManager.getFloorUsableBeacons();
    final beaconMap = getGroupBeacons(beacons);
    // final floorId = getFloorDetectionResult(beaconMap);
    final floorId = filterFloorNoise(
      getFloorDetectionResult(beaconMap),
      enabled: false,
    );
    if (floorId != null) {
      _currentFloor = floorId;
      onChange(floorId);
    }
  }

  int? filterFloorNoise(int? floorId, {bool enabled = true}) {
    if (!enabled) return floorId;

    if (floorId != null) {
      if (_currentFloor != _willUpdateFloor) {
        if (_willUpdateFloor == null || _willUpdateFloor == floorId) {
          _updateFloorCounter += 1;
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

  // void testFloorDetection2() {
  //   final usableBeacons = _beaconManager.getUsableBeacons();
  //   if (usableBeacons.isEmpty) return;
  //   final ids = getFloorIds(usableBeacons);
  //   if (ids.isEmpty) return;
  //   int floorId = ids.first;
  //   double minDistance = calMeanDistanceByFloor(usableBeacons, floorId);

  //   ids.forEach((floor) {
  //     double distance = calMeanDistanceByFloor(usableBeacons, floor);
  //     if (distance < minDistance) {
  //       minDistance = distance;
  //       floorId = floor;
  //     }
  //   });
  //   onChange(floorId);
  // }

  // void testFloorDetection() {
  //   final usableBeacons = _beaconManager.getUsableBeacons();
  //   if (usableBeacons.isEmpty) return;
  //   Map<int, double> floorAndDistance = {};
  //   if (usableBeacons.isNotEmpty) {
  //     usableBeacons.forEach((e) {
  //       var floorId = e.location!.floorPlanId;
  //       if (floorAndDistance.containsKey(floorId)) {
  //         double distance = e.getDistanceAvg();
  //         if (floorAndDistance[floorId]! > distance) {
  //           floorAndDistance[floorId] = distance;
  //         }
  //       } else {
  //         floorAndDistance.putIfAbsent(
  //           floorId,
  //           () => e.getDistanceAvg(),
  //         );
  //       }
  //     });
  //     if (floorAndDistance.isNotEmpty) {
  //       int floorId = floorAndDistance.keys.first;
  //       double minDistance = floorAndDistance.values.first;
  //       floorAndDistance.forEach((floor, distance) {
  //         if (distance < minDistance) {
  //           floorId = floor;
  //         }
  //       });
  //       onChange(floorId);
  //     }
  //   }
  // }

  /// Perform floor detection
  // void floorDetection() {
  //   final usableBeacons = _beaconManager.getUsableBeacons();
  //   if (usableBeacons.isNotEmpty) {
  //     int? floor = determineFloor(usableBeacons);
  //     if (floor != null) {
  //       onChange(floor);
  //     }
  //   }
  // }

  /// Determine floor
  ///
  /// If only one floor found, return the floor as current floor
  /// Else perform min average distance for each floor
  // int? determineFloor(List<Beacon> usableBeacons) {
  //   int? result;
  //   final floorIds = getFloorIds(usableBeacons);
  //   if (floorIds.length == 1) {
  //     result = usableBeacons.first.location!.floorPlanId;
  //   } else {
  //     final satisfiedBeacons = getBeaconSatisfied(usableBeacons);
  //     if (satisfiedBeacons.isNotEmpty) {
  //       result = getCurrentFloor(satisfiedBeacons, floorIds.toList());
  //     } else {
  //       result = getMostOccurenceFloorId(usableBeacons);
  //     }
  //   }

  //   return result;
  // }

  /// Beacon group on vertical slice that is satisfied condition
  ///
  /// Condition: Each group must have min beacon found depends on the largest group
  // List<Beacon> getBeaconSatisfied(List<Beacon> beacons) {
  //   Map<int, List<Beacon>> beaconGroup = {};
  //   beacons.forEach((e) {
  //     if (e.beaconGroupId != null) {
  //       var beaconList = beaconGroup.putIfAbsent(e.beaconGroupId!, () => []);
  //       beaconList.add(e);
  //     }
  //   });
  //   beacons.forEach((e) {
  //     if (beaconGroup.containsKey(e.id)) {
  //       beaconGroup[e.id!]!.add(e);
  //     }
  //   });
  //   if (beaconGroup.isEmpty) {
  //     return [];
  //   }

  //   int maxLength = getListMaxLength(beaconGroup);
  //   return beaconGroup.values
  //       .where((e) => e.length == maxLength)
  //       .expand((e) => e)
  //       .toList();
  // }

  // int getMostOccurenceFloorId(List<Beacon> beacons) {
  //   Map<int, int> floorOccur = {};
  //   beacons.forEach((e) {
  //     if (floorOccur.containsKey(e.location!.floorPlanId)) {
  //       floorOccur[e.location!.floorPlanId] =
  //           floorOccur[e.location!.floorPlanId]! + 1;
  //     } else {
  //       floorOccur.putIfAbsent(e.location!.floorPlanId, () => 1);
  //     }
  //   });

  //   int floorId = floorOccur.keys.first;
  //   int occurs = floorOccur.values.first;
  //   floorOccur.forEach((key, value) {
  //     if (occurs < value) {
  //       floorId = key;
  //       occurs = value;
  //     }
  //   });
  //   return floorId;
  // }

  // /// Calculate mean distance from all Beacon of a floor to user device
  // double calMeanDistanceByFloor(List<Beacon> list, int floorId) {
  //   var satisfied = list.where((e) => e.location!.floorPlanId == floorId);
  //   if (satisfied.isEmpty) return double.infinity;
  //   Iterable<double> rssiList = satisfied
  //       .where((e) => e.packetManager.isNotEmpty())
  //       .map((e) => e.getDistanceAvg()!);
  //   if (rssiList.isEmpty) return double.infinity;
  //   return MeanFilter.average(rssiList);
  // }

  // /// Get current floor
  // int getCurrentFloor(List<Beacon> list, List<int> floorIds) {
  //   int currentFloor = floorIds[0];
  //   double minDistance = calMeanDistanceByFloor(list, floorIds.first);
  //   floorIds.getRange(1, floorIds.length).forEach((id) {
  //     double distance = calMeanDistanceByFloor(list, id);
  //     if (distance < minDistance) {
  //       minDistance = distance;
  //       currentFloor = id;
  //     }
  //   });
  //   return currentFloor;
  // }

  // /// Get the length of the largest beacon group
  // int getListMaxLength(Map<int, List<Beacon>> beaconGroup) {
  //   return beaconGroup.values.map((e) => e.length).reduce(max);
  // }

  // /// Get list of all floorId detected
  // Set<int> getFloorIds(List<Beacon> beacons) {
  //   Set<int> floorIds = Set();
  //   beacons.map((e) => e.location!.floorPlanId).forEach((id) {
  //     floorIds.add(id);
  //   });
  //   return floorIds;
  // }
}
