import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/const.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';

class Packet {
  final int rssi;
  final int timeStamp;

  Packet({
    required this.rssi,
    required this.timeStamp,
  });

  bool isBetween(int minTimeStamp, int maxTimeStamp) {
    return timeStamp >= minTimeStamp && timeStamp <= maxTimeStamp;
  }

  bool isOld() {
    int current = Utils.getCurrentTimeStamp();
    return current - timeStamp > Const.longInterval.inMilliseconds;
  }

  String toString() {
    return rssi.toString();
  }
}
