import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/managers/packet_manager.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/beacon.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';

mixin IBeaconManager {
  void addBeaconFound(String uuid, int rssi);
  void removeOldBeacon();
  List<Beacon> getUsableBeacons([int? floorPlanId]);
  List<int> getBeaconGroups();
}

class BeaconManager implements IBeaconManager {
  /// Beacon list in DB
  late List<Beacon> beacons;

  /// Beacon list found by scanning
  final List<Beacon> _beaconsFound = [];

  BeaconManager({required this.beacons});

  @override
  void addBeaconFound(
    String uuid,
    int rssi,
  ) {
    final beaconFound = findBeaconFound(uuid) ??
        addIfNonNull(_beaconsFound, findBeaconValid(uuid));
    if (beaconFound != null) {
      int current = Utils.getCurrentTimeStamp();
      beaconFound.lastSeen = current;
      beaconFound.packetManager.addPacket(rssi, current);
    }
  }

  @override
  void removeOldBeacon() {
    _beaconsFound.removeWhere((e) => !e.isRecentlySeen());
  }

  @override
  List<Beacon> getUsableBeacons([int? floorPlanId]) {
    _beaconsFound.forEach((e) {
      e.distance = null;
    });
    if (floorPlanId == null) {
      return _beaconsFound.where((e) => e.packetManager.isNotEmpty()).toList();
    }
    return _beaconsFound
        .where((e) =>
            e.location!.floorPlanId == floorPlanId &&
            e.packetManager.isNotEmpty())
        .toList();
  }

  Beacon? addIfNonNull(List<Beacon> list, Beacon? beacon) {
    if (beacon != null) {
      list.add(beacon);
      return beacon;
    }
  }

  Beacon? findBeaconValid(String uuid) {
    final b = findByUuid(beacons, uuid)?.clone();
    b?.packetManager = PacketManager();
    return b;
  }

  Beacon? findBeaconFound(String uuid) => findByUuid(_beaconsFound, uuid);

  Beacon? findByUuid(List<Beacon> list, String uuid) {
    final b = list.firstWhere((e) => e.uuid == uuid, orElse: () => Beacon());
    if (b.uuid != null) {
      return b;
    }
  }

  @override
  List<Beacon> getFloorUsableBeacons() {
    // try {
    //   final groupIds = beacons
    //       .where((e) => e.beaconGroupId != null)
    //       .map((e) => e.beaconGroupId);
    //   final beaconInGroup = beacons
    //       .where((e) =>
    //           groupIds.contains(e.id) || groupIds.contains(e.beaconGroupId))
    //       .map((e) => e.clone());
    //   final beaconFoundInGroupIds = _beaconsFound.map((e) => e.id);
    //   final result = [
    //     ..._beaconsFound,
    //     ...beaconInGroup.where((e) => !beaconFoundInGroupIds.contains(e.id))
    //   ];
    //   result.forEach((e) {
    //     e.distance = null;
    //   });
    //   return result;
    // } catch (e) {
    //   print(1);
    // }
    return beacons.map((e) {
      e.packetManager = PacketManager();
      return e.clone();
    }).toList();
  }

  @override
  List<int> getBeaconGroups() {
    return beacons
        .where((e) => e.beaconGroupId != null)
        .map((e) => e.beaconGroupId!)
        .toList();
  }
}
