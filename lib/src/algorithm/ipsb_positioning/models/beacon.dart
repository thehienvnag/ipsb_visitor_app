import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/managers/packet_manager.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/filters/mean_filter.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/const.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';

import 'location_2d.dart';

class Beacon {
  final int? id;
  final String? uuid;
  final double? txPower;
  final int? beaconGroupId;
  double? distance;

  final Location2d? location;
  late IPacketManager packetManager = PacketManager();
  int lastSeen = Const.timeStampNotSet;

  Beacon({
    this.id,
    this.uuid,
    this.location,
    this.beaconGroupId,
    this.txPower,
  });

  double? getDistanceAvg() {
    // Average Rssi
    if (packetManager.isNotEmpty()) {
      double rssi = MeanFilter.average(packetManager.getListRssi());
      packetManager.removeAll();

      // Calculate distance
      return Utils.rssiDistance(
        rssi,
        txPower!,
      );
    } else {
      return double.infinity;
    }
  }

  double? getDistance(double mapScale) {
    final meterToPixel = 3779.52755906;
    if (packetManager.getListRssi().isNotEmpty) {
      // Average Rssi
      double rssi = MeanFilter.average(packetManager.getListRssi());
      packetManager.removeAll(spareOne: true);

      // Calculate distance
      final distanceMeter = Utils.rssiDistance(
        rssi,
        txPower!,
      );

      // If distance smaller than 10
      if (distanceMeter > 0 && distanceMeter < 3.5) {
        return distanceMeter / mapScale * meterToPixel;
      }
    }
  }

  Beacon clone() {
    return Beacon(
      id: this.id,
      beaconGroupId: this.beaconGroupId,
      location: this.location,
      txPower: this.txPower,
      uuid: this.uuid,
    );
  }
}
