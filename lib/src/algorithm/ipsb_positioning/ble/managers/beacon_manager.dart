import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/managers/packet_manager.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/beacon.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';

mixin IBeaconManager {
  void addBeaconFound(String uuid, int rssi);
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
  List<Beacon> getUsableBeacons([int? floorPlanId]) {
    _beaconsFound.forEach((e) {
      e.distance = null;
      e.location?.distance = null;
    });
    if (floorPlanId == null) {
      _beaconsFound.forEach((e) {});
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
  List<int> getBeaconGroups() {
    return beacons
        .where((e) => e.beaconGroupId != null)
        .map((e) => e.beaconGroupId!)
        .toList();
  }
}
