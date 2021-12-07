import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/const.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';

class Location2d {
  final double x, y;
  int floorPlanId;
  int timeStamp;
  double? distance;

  Location2d({
    this.distance,
    this.floorPlanId = 0,
    this.timeStamp = -1,
    required this.y,
    required this.x,
  });

  double getDistanceTo(Location2d toLocation) {
    return Utils.distance(this, toLocation);
  }

  bool isOld() {
    int current = Utils.getCurrentTimeStamp();
    return current - timeStamp > Const.expiredLocation.inMilliseconds;
  }

  @override
  String toString() {
    return '($x, $y)';
  }
}
