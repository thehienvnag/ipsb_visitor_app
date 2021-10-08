import 'dart:async';
import 'dart:math';

import 'package:flutter_compass/flutter_compass.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/pdr/step_detector.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/positioning.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart';

class PdrPositioningConfig extends PositioningConfig {
  /// Rotation of the floor map compared to the true north [rotation]
  final double rotation;

  /// Average step length on each step [stepLength]
  final double stepLength;

  PdrPositioningConfig({
    required this.rotation,
    this.stepLength = 0.7, // Assuming that average step of user is of 0.7 meter
  });
}

mixin IPdrPositioning on Positioning {
  /// Start
  void start();

  /// Pause
  void pause();

  /// Resume
  void resume();

  /// Subcribe to stream of new location
  Stream<Location2d> get locationEvents;

  /// Unsubcribe to stream of new location
  void stop();

  /// Setter location
  void setInitial(Location2d? initial);

  /// Getter Getter location
  Location2d? get initial;
}

class PdrPositioning implements IPdrPositioning {
  /// Controller for current location stream
  StreamController<Location2d>? _locationController;

  /// Configurations for Pdr Positioning
  late final PdrPositioningConfig _config;

  /// Step detector implementation
  late final IStepDetector? _stepDetector;

  /// Current heading direction
  double? _heading;

  /// Compass Event Subscription
  StreamSubscription<CompassEvent>? _compassEventSub;

  /// User Accelerometer Event Subscription
  StreamSubscription<UserAccelerometerEvent>? _userAccelerometerEventSub;

  /// Initial location [initial]
  late Location2d? _initial;

  @override
  Location2d? get initial => _initial;

  @override
  setInitial(Location2d? initial) {
    _initial = initial;
  }

  @override
  void init(PositioningConfig config) {
    _config = config as PdrPositioningConfig;
  }

  @override
  Stream<Location2d> get locationEvents => _locationController!.stream;

  @override
  void pause() {
    _compassEventSub?.cancel();
    _userAccelerometerEventSub?.cancel();
    _compassEventSub = null;
    _userAccelerometerEventSub = null;
  }

  @override
  void resume() {
    if (_compassEventSub == null) {
      _compassEventSub = FlutterCompass.events?.listen((event) {
        _heading = event.heading;
      });
    }
    if (_userAccelerometerEventSub == null) {
      _userAccelerometerEventSub = userAccelerometerEvents.listen((event) {
        _stepDetector?.onAccelerometerChange(event);
      });
    }
  }

  @override
  void start() {
    _locationController = StreamController<Location2d>.broadcast();
    initCompass();
    initStepDetector();
  }

  void stop() {
    _stepDetector = null;
    _compassEventSub?.cancel();
    _locationController?.close();
    _userAccelerometerEventSub?.cancel();
  }

  /// Init the compass for determine heading direction
  void initCompass() {
    _compassEventSub = FlutterCompass.events?.listen((event) {
      _heading = event.heading;
    });
  }

  /// Init the step detector
  void initStepDetector() {
    _stepDetector = StepDetector(onStep: onStep);
    _userAccelerometerEventSub = userAccelerometerEvents.listen((event) {
      _stepDetector?.onAccelerometerChange(event);
    });
  }

  void onStep(DateTime dateTime) async {
    double stepLength = _config.stepLength;
    double rotation = _config.rotation;
    if (_heading == null) return; // No new location if _heading == null
    if (_initial == null) return; // No new location if initial == null
    // PDR equation with step length and heading
    final location = Location2d(
      x: _initial!.x + stepLength * cos(radians(_heading! - rotation)),
      y: _initial!.y + stepLength * sin(radians(_heading! - rotation)),
    );
    _locationController?.add(location);
  }
}
