import 'dart:async';

import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/filters/kalman_filter_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/ble_positioning.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/pdr_positioning.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/positioning.dart';

mixin IDataFusion {
  void init({
    required PositioningConfig bleConfig,
    required PositioningConfig pdrConfig,
  });
  void start();
  void stop();
}

class DataFusion implements IDataFusion {
  /// Delay duration
  final Duration longerInterval = const Duration(milliseconds: 3500);

  /// 2d kalman filter
  final KalmanFilter2d _filter = KalmanFilter2d(
    processNoise: 0.005,
    measurementNoise: 1.25,
  );

  /// Ble positioning method
  late final IBlePositioning _blePositioning;

  /// Pdr positioning method
  late final IPdrPositioning _pdrPositioning;

  /// Timer for periodic fusion workflow
  Timer? _timer;

  /// Current location;
  Location2d? _current;

  /// Current floor
  int? _currentFloor;

  final void Function(int) onFloorChange;

  /// On location updated
  final void Function(Location2d?, void Function(Location2d)) onChange;

  DataFusion({required this.onChange, required this.onFloorChange});

  @override
  void init({required bleConfig, required pdrConfig}) {
    // Init config for Ble method
    _blePositioning = BlePositioning();
    _blePositioning.init(bleConfig);

    // Init config for Pdr method
    _pdrPositioning = PdrPositioning();
    _pdrPositioning.init(pdrConfig);
  }

  @override
  void start() async {
    runPeriodic();
    initBleMethod();
    initPdrMethod();
  }

  void initBleMethod() {
    _blePositioning.start();
    _blePositioning.currentFloorEvents.listen((e) async {
      _currentFloor = e;
      onFloorChange(e);
    });
  }

  void initPdrMethod() async {
    // Set the initial location for pdr method
    _pdrPositioning.start();
    _pdrPositioning.setInitial(_current);
    _pdrPositioning.locationEvents.listen((e) {
      if (e.floorPlanId == _currentFloor) {
        _current = e;
        onChange(e, setCurrent);
      }
    });
  }

  void setCurrent(Location2d location2d) {
    _current = location2d;
  }

  void runPeriodic() async {
    _current = await initLocation();
    _timer = Timer.periodic(longerInterval, (timer) async {
      _pdrPositioning.pause();
      if (_current != null) {
        _filter.predict(_current!);
        final measured = _blePositioning.resolve(_currentFloor);
        if (measured != null) {
          _filter.correct(measured);
          _current = _filter.state;
        }
        onChange(_current, setCurrent);
      } else {
        _current = await initLocation();
      }
      _pdrPositioning.setInitial(_current);
      _pdrPositioning.resume();
    });
  }

  @override
  void stop() {
    _timer?.cancel();
    _blePositioning.stop();
    _pdrPositioning.stop();
  }

  Future<Location2d?> initLocation() async {
    const initialInterval = const Duration(milliseconds: 2500);
    final location = await Future.delayed(initialInterval, () {
      return _blePositioning.resolve(_currentFloor);
    });
    return location;
  }
}
