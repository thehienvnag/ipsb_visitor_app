import 'dart:convert';

import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/ble_positioning.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';

abstract class BaseBleAction {
  /// Init the ble method
  void init(BlePositioningConfig config);

  /// Handle scan
  void handleScanData(String uuid, int rssi);

  /// Process scan results
  void processScanResults(String scanResult) {
    if (scanResult.isNotEmpty) {
      final json = jsonDecode(scanResult);
      String uuid = json["uuid"];
      int rssi = int.parse(json["rssi"]);
      String macAddress = json["macAddress"];
      handleScanData(Utils.getUuid(uuid, macAddress), rssi);
    }
  }
}
