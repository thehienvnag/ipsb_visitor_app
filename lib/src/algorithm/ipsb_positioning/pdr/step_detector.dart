import 'package:sensors_plus/sensors_plus.dart';

class StepDetectorConfig {
  static const double STANDARD_GRAVITY = 9.80665;
  static const double MAGNETIC_FIELD_EARTH_MAX = 60.0;
}

mixin IStepDetector {
  onAccelerometerChange(UserAccelerometerEvent data);
}

class StepDetector implements IStepDetector {
  /// Sperimentally found on my slow walk. It was 10.0 before
  double mLimit = 1.8;

  List<double> mLastValues = List.generate(6, (index) => 0);
  List<double> mScale = [
    -(480 * 0.5 * (1.0 / (StepDetectorConfig.STANDARD_GRAVITY * 2))),
    -(480 * 0.5 * (1.0 / (StepDetectorConfig.MAGNETIC_FIELD_EARTH_MAX * 2))),
  ];
  late double mYOffset = 240;

  List<double> mLastDirections = List.generate(6, (index) => 0);
  List<List<double>> mLastExtremes = [
    List.generate(6, (index) => 0),
    List.generate(6, (index) => 0)
  ];
  List<double> mLastDiff = List.generate(6, (index) => 0);
  int mLastMatch = -1;

  /// Callback function once new step is detected
  Function(DateTime)? onStep;
  StepDetector({this.onStep});

  @override
  void onAccelerometerChange(UserAccelerometerEvent data) {
    double vSum = 0;

    vSum += mYOffset + data.x * mScale[1];
    vSum += mYOffset + data.y * mScale[1];
    vSum += mYOffset + data.z * mScale[1];

    int k = 0;
    double v = vSum / 3;

    double direction = (v > mLastValues[k] ? 1 : (v < mLastValues[k] ? -1 : 0));
    if (direction == -mLastDirections[k]) {
      // Direction changed
      int extType = (direction > 0 ? 0 : 1); // minimum or maximum?
      mLastExtremes[extType][k] = mLastValues[k];
      double diff =
          (mLastExtremes[extType][k] - mLastExtremes[1 - extType][k]).abs();

      if (diff > mLimit) {
        bool isAlmostAsLargeAsPrevious = diff > (mLastDiff[k] * 2 / 3);
        bool isPreviousLargeEnough = mLastDiff[k] > (diff / 3);
        bool isNotContra = (mLastMatch != 1 - extType);

        if (isAlmostAsLargeAsPrevious && isPreviousLargeEnough && isNotContra) {
          if (onStep != null)
            onStep!(DateTime.now());
          else
            print("<Callback>onStep is null</Callback>");
          mLastMatch = extType;
        } else {
          mLastMatch = -1;
        }
      }
      mLastDiff[k] = diff;
    }
    mLastDirections[k] = direction;
    mLastValues[k] = v;
  }
}
