import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/managers/packet_manager.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/filters/mean_filter.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/const.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';

import 'location_2d.dart';

class Beacon {
  final String? uuid;
  final int? txPower;
  final int? beaconGroupId;

  final Location2d? location;
  final IPacketManager packetManager = PacketManager();
  int lastSeen = Const.timeStampNotSet;

  Beacon({
    this.uuid,
    this.location,
    this.beaconGroupId,
    this.txPower,
  });

  double getDistanceAvg(double environmentFactor) {
    return MeanFilter.average(packetManager
        .getListRssi()
        .map((rssi) => Utils.rssiDistance(rssi, txPower!, environmentFactor)));
  }

  void getAndSetDistance(double environmentFactor) {
    double rssi = packetManager.getListRssi().first;
    packetManager.removeFirst();
    location?.distance = Utils.rssiDistance(rssi, txPower!, environmentFactor);
  }

  bool isRecentlySeen() {
    int current = Utils.getCurrentTimeStamp();
    return current - this.lastSeen <= Const.longInterval.inMilliseconds;
  }
}
