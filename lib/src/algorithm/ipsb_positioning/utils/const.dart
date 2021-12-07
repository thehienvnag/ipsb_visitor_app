import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/beacon.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';

class Const {
  /// Initial value of timestamp
  static final int timeStampNotSet = -1;

  /// Initial value of distance
  static final double distanceNotSet = -1;

  /// Minimum location value count for Mean Filter
  static final int minLocationCount = 5;

  /// Interval between a location estimation
  static final Duration longInterval = Duration(milliseconds: 2500);

  /// Interval between rssi expired
  static final Duration expiredLocation = Duration(milliseconds: 3500);

  /// Delay for first time init location estimation
  static final Duration initDuration = Duration(milliseconds: 500);

  /// Default initial location
  static final Location2d undefinedLocation =
      Location2d(y: -999, x: -999, timeStamp: -1);

  /// Minimum beacons count for  multi-trilateration
  static final int minBeaconCount = 3;

  /// (FUTURE) balance position based on human walking speed
  static final double humanWalkingSpeed = 1.388889;

  static final Beacon undefinedBeacon = Beacon(
    uuid: "",
    location: undefinedLocation,
  );
}
