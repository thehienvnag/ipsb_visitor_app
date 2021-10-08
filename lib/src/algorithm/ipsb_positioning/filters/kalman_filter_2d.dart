import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/utils/utils.dart';
import 'package:linalg/linalg.dart';

class KalmanFilter2dConstant {
  static final identityMatrix = Matrix([
    [1, 0],
    [0, 1]
  ]);
}

mixin IKalmanFilter2d {
  void predict(Location2d current);
  void correct(Location2d measurement);
  Location2d get state;
}

class KalmanFilter2d implements IKalmanFilter2d {
  late Matrix _state;
  Matrix _processNoise = KalmanFilter2dConstant.identityMatrix;
  Matrix? _kalmanGain;
  late int _floorPlanId;

  final double processNoise;
  final double measurementNoise;

  KalmanFilter2d({
    required this.processNoise,
    required this.measurementNoise,
  });

  @override
  void predict(Location2d current) {
    _state = Matrix([
      [current.x],
      [current.y],
    ]);
    _floorPlanId = current.floorPlanId;

    /// Identity matrix
    final identity = KalmanFilter2dConstant.identityMatrix;

    //P'(k) = P(k-1) + Q
    _processNoise += identity * processNoise;

    //S(k) = P'(k) + R
    var residualCov = _processNoise + identity * measurementNoise;

    //S(k)^(-1)
    var residualCovInv = residualCov.inverse();

    //K(k) = P'(k) * S(k)^(-1)
    _kalmanGain = _processNoise * residualCovInv;
  }

  @override
  void correct(Location2d measured) {
    if (_kalmanGain == null) return;
    final mVector = Matrix([
      [measured.x],
      [measured.y],
    ]);
    // x = x'(t) + K(t) * ( z(t) - x'(t) )
    _state += _kalmanGain! * (mVector - _state).toVector();
  }

  @override
  Location2d get state => Location2d(
        y: _state[0][0],
        x: _state[1][0],
        floorPlanId: _floorPlanId,
        timeStamp: Utils.getCurrentTimeStamp(),
      );
}
