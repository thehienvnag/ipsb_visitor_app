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

  /// Current floor
  int? _currentFloor;

  /// Current location
  Location2d? _currentLocation;

  /// floor changing status
  bool onFloorChanging = false;

  /// Location changing status
  bool onLocationChanging = false;

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
    initBleMethod();
    initPdrMethod();
    runPeriodicBleLocation();
  }

  void runPeriodicBleLocation() {
    Timer.periodic(Duration(seconds: 8), (timer) {
      if (!onFloorChanging && _currentFloor != null) {
        onLocationChanging = true;
        try {
          if (_currentLocation != null) {
            _pdrPositioning.pause();
            _filter.predict(_currentLocation!);
            final measured = _blePositioning.resolve(_currentFloor);
            if (measured != null) {
              _filter.correct(measured);
              onChange(_filter.state, setCurrent);
            }
            _pdrPositioning.resume();
          } else {
            final location = _blePositioning.resolve(_currentFloor);
            if (location != null) {
              onChange(location, setCurrent);
            }
          }
        } catch (e) {}

        onLocationChanging = false;
      }
    });
  }

  void initBleMethod() {
    _blePositioning.start();
    _blePositioning.currentFloorEvents.listen((e) async {
      if (_currentFloor != e) {
        _currentFloor = e;
        onFloorChange(e);
        getBleLocationFloorChange();
      }
    });
  }

  void initPdrMethod() async {
    // _currentFloor = 18;
    // onFloorChange(_currentFloor!);
    // final initial = Location2d(
    //   x: 190.364990234375,
    //   y: 600,
    //   floorPlanId: 18,
    // );
    // Future.delayed(Duration(milliseconds: 3000), () {
    //   onChange(initial, setCurrent);
    // });

    _pdrPositioning.start();
    // _pdrPositioning.setInitial(initial);
    _pdrPositioning.locationEvents.listen((e) {
      if (e.floorPlanId == _currentFloor) {
        onChange(e, setCurrent);
      }
    });
  }

  void setCurrent(Location2d location2d) {
    print(location2d);
    _currentLocation = location2d;
    _pdrPositioning.setInitial(location2d);
  }

  void getBleLocationFloorChange() async {
    if (!onLocationChanging) {
      onFloorChanging = true;
      try {
        final newLocation = await initLocation();
        if (newLocation != null) {
          _pdrPositioning.pause();
          onChange(newLocation, setCurrent);
          _pdrPositioning.resume();
        }
        onFloorChanging = false;
      } catch (e) {}
    }
  }

  Future<Location2d?> initLocation() async {
    const initialInterval = const Duration(seconds: 5);
    final location = await Future.delayed(initialInterval, () {
      return _blePositioning.resolve(_currentFloor, removeOldLocation: false);
    });
    return location;
  }

  @override
  void stop() {
    _timer?.cancel();
    _blePositioning.stop();
    // _pdrPositioning.stop();
  }
}
