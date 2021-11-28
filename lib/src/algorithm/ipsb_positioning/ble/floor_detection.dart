import 'dart:async';
import 'dart:math';

import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/base_ble_action.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/managers/beacon_manager.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/filters/mean_filter.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/beacon.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/ble_positioning.dart';

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

  /// Perform floor detection
  void floorDetection() {
    final usableBeacons = _beaconManager.getUsableBeacons();
    if (usableBeacons.isNotEmpty) {
      int? currentFloor = determineFloor(usableBeacons);
      if (currentFloor != null) {
        onChange(currentFloor);
      }
    }
  }

  /// Determine floor
  ///
  /// If only one floor found, return the floor as current floor
  /// Else perform min average distance for each floor
  int? determineFloor(List<Beacon> usableBeacons) {
    int? result;
    final floorIds = getFloorIds(usableBeacons);
    if (floorIds.length == 1) {
      result = usableBeacons.first.location!.floorPlanId;
    } else {
      final satisfiedBeacons = getBeaconSatisfied(usableBeacons);
      if (satisfiedBeacons.isNotEmpty) {
        result = getCurrentFloor(satisfiedBeacons, floorIds.toList());
      } else {
        result = getMostOccurenceFloorId(usableBeacons);
      }
    }

    return result;
  }

  /// Beacon group on vertical slice that is satisfied condition
  ///
  /// Condition: Each group must have min beacon found depends on the largest group
  List<Beacon> getBeaconSatisfied(List<Beacon> beacons) {
    Map<int, List<Beacon>> beaconGroup = {};
    beacons.forEach((e) {
      if (e.beaconGroupId != null) {
        var beaconList = beaconGroup.putIfAbsent(e.beaconGroupId!, () => []);
        beaconList.add(e);
      }
    });
    beacons.forEach((e) {
      if (beaconGroup.containsKey(e.id)) {
        beaconGroup[e.id!]!.add(e);
      }
    });
    if (beaconGroup.isEmpty) {
      return [];
    }

    int maxLength = getListMaxLength(beaconGroup);
    return beaconGroup.values
        .where((e) => e.length == maxLength)
        .expand((e) => e)
        .toList();
  }

  int getMostOccurenceFloorId(List<Beacon> beacons) {
    Map<int, int> floorOccur = {};
    beacons.forEach((e) {
      if (floorOccur.containsKey(e.location!.floorPlanId)) {
        floorOccur[e.location!.floorPlanId] =
            floorOccur[e.location!.floorPlanId]! + 1;
      } else {
        floorOccur.putIfAbsent(e.location!.floorPlanId, () => 1);
      }
    });

    int floorId = floorOccur.keys.first;
    int occurs = floorOccur.values.first;
    floorOccur.forEach((key, value) {
      if (occurs < value) {
        floorId = key;
        occurs = value;
      }
    });
    return floorId;
  }

  /// Calculate mean distance from all Beacon of a floor to user device
  double calMeanDistanceByFloor(List<Beacon> list, int floorId) {
    var satisfied = list.where((e) => e.location!.floorPlanId == floorId);
    if (satisfied.isEmpty) return double.infinity;
    return MeanFilter.average(
      satisfied.map((e) => e.getDistanceAvg()),
    );
  }

  /// Get current floor
  int getCurrentFloor(List<Beacon> list, List<int> floorIds) {
    int currentFloor = floorIds[0];
    double minDistance = calMeanDistanceByFloor(list, floorIds.first);
    floorIds.getRange(1, floorIds.length).forEach((id) {
      double distance = calMeanDistanceByFloor(list, id);
      if (distance < minDistance) {
        minDistance = distance;
        currentFloor = id;
      }
    });
    return currentFloor;
  }

  /// Get the length of the largest beacon group
  int getListMaxLength(Map<int, List<Beacon>> beaconGroup) {
    return beaconGroup.values.map((e) => e.length).reduce(max);
  }

  /// Get list of all floorId detected
  Set<int> getFloorIds(List<Beacon> beacons) {
    Set<int> floorIds = Set();
    beacons.map((e) => e.location!.floorPlanId).forEach((id) {
      floorIds.add(id);
    });
    return floorIds;
  }
}
