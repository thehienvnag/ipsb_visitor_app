import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';

class MeanFilter {
  static Location2d filter(Iterable<Location2d> locations) {
    double xMean = 0, yMean = 0;

    locations.forEach((element) {
      xMean += element.x;
    });
    locations.forEach((element) {
      yMean += element.y;
    });
    return Location2d(
      timeStamp: Utils.getCurrentTimeStamp(),
      y: yMean / locations.length,
      x: xMean / locations.length,
      floorPlanId: locations.first.floorPlanId,
    );
  }

  static double average(Iterable<double> list) {
    return list.reduce((a, b) => a + b) / list.length;
  }
}
