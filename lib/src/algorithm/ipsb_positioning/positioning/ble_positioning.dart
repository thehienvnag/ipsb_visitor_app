import 'dart:async';

import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/floor_detection.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/ble/trilateration.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/beacon.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/positioning.dart';

class BlePositioningConfig extends PositioningConfig {
  /// Private beacons
  final List<Beacon> beacons;

  BlePositioningConfig({
    required this.beacons,
    required double mapScale,
  }) : super(mapScale: mapScale);
}

mixin IBlePositioning on Positioning {
  Stream<int> get currentFloorEvents;
  Location2d? resolve(int? floorId);
  void start();
  void stop();
}

class BlePositioning implements IBlePositioning {
  /// Controller for current floor stream
  final StreamController<int> _currentFloor = StreamController<int>.broadcast();

  @override
  Stream<int> get currentFloorEvents => _currentFloor.stream;

  /// Configurations for Ble Positioning
  late final BlePositioningConfig _config;

  /// Beacon stream controller;
  StreamController<String>? _beaconScanned;

  /// Floor detection instance
  BaseFloorDetection? _floorDetection;

  /// Floor detection instance
  BaseTrilateration? _trilateration;

  @override
  void init(PositioningConfig config) {
    _config = config as BlePositioningConfig;
  }

  @override
  Location2d? resolve(int? floorId) {
    if (floorId != null) {
      return _trilateration?.resolveLocation(floorId);
    }
  }

  @override
  void start() {
    initPlugin();
    initBle();
  }

  @override
  void stop() {
    BeaconsPlugin.stopMonitoring();
    _currentFloor.close();
    _beaconScanned?.close();
    _floorDetection?.stop();
  }

  void initPlugin() {
    _beaconScanned = StreamController<String>.broadcast();
    BeaconsPlugin.startMonitoring();
    BeaconsPlugin.setForegroundScanPeriodForAndroid(foregroundScanPeriod: 200);
    BeaconsPlugin.listenToBeacons(_beaconScanned!);
  }

  void initBle() {
    _floorDetection = FloorDetection(
      onChange: (floorId) {
        _currentFloor.add(floorId);
      },
    );
    _floorDetection?.init(_config);

    _trilateration = Trilateration(
      currentFloorEvents: _currentFloor.stream,
    );
    _trilateration?.init(_config);

    _beaconScanned?.stream.listen((scanResult) {
      _floorDetection?.processScanResults(scanResult);
      _trilateration?.processScanResults(scanResult);
    });
  }
}
