import 'dart:math';

import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/const.dart';

class Utils {
  static int getCurrentTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// Distance between 2 points: d=√((x_2-x_1)²+(y_2-y_1)²)
  ///
  /// where [p1]: (x_1, y_1) and [p2]: (x_2, y_2)
  static double distance(Location2d p1, Location2d p2) {
    return sqrt(
      pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2),
    ).toDouble();
  }

  /// Distance between iBeacon transmitter and mobile device
  ///
  /// [rssi]: current scan rssi
  /// [txPower]: calibrated rssi at 1m
  /// [environmentFactor]: environment factor at deployed site
  static double rssiDistance(
    double rssi,
    double txPower,
  ) {
    if (rssi == 0) {
      return -1.0; // if we cannot determine accuracy, return -1.
    }
    double ratio = rssi / txPower;
    if (ratio < 1.0) {
      return pow(ratio, 10).toDouble();
    } else {
      double accuracy = (0.89976) * pow(ratio, 7.7095) + 0.111;
      return accuracy.toDouble();
    }
    // return pow(10, (txPower - rssi) / (10 * environmentFactor))
    //     .toDouble(); //Old version
  }

  /// Uuid of beacon
  ///
  /// [uuid]: uuid string
  /// [macAddress]: mac address string
  static String getUuid(String uuid, String? macAddress) {
    final Map<String, String> listUuid = const {
      "65:23:A4:38:D0:E5": "fda50693-a4e2-4fb1-afcf-c6eb07647521",
      "2C:92:E9:7B:AF:E0": "fda50693-a4e2-4fb1-afcf-c6eb07647522",
      "C3:3B:1F:7E:1B:E1": "fda50693-a4e2-4fb1-afcf-c6eb07647523",
      "17:43:CC:F0:61:D6": "fda50693-a4e2-4fb1-afcf-c6eb07647524",
      "74:6C:B8:18:9D:C8": "fda50693-a4e2-4fb1-afcf-c6eb07647525",
    };
    if (uuid == "fda50693-a4e2-4fb1-afcf-c6eb07647825" &&
        macAddress != null &&
        listUuid.containsKey(macAddress)) {
      return listUuid[macAddress]!;
    }
    return uuid;
  }
}
