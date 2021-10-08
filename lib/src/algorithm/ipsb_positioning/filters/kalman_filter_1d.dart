class KalmanFilter1d {
  /// Process noise
  num R;

  /// Measurement noise
  num Q;

  /// State vector
  num A;

  /// Control vector
  num B;

  /// Measurement vector
  num C;

  /// Estimated signal without noise
  num x;

  num cov;
  KalmanFilter1d({
    this.R = 1.4,
    this.Q = 0.065,
    this.A = 1,
    this.B = 0,
    this.C = 1,
    this.x = -1,
    this.cov = -1,
  });

  filter(z, [u = 0]) {
    if (this.x == -1) {
      this.x = (1 / this.C) * z;
      this.cov = (1 / this.C) * this.Q * (1 / this.C);
    } else {
      // Compute prediction
      double predX = this.predict(u);
      double predCov = this.uncertainty();

      // Kalman gain
      double K =
          predCov * this.C * (1 / ((this.C * predCov * this.C) + this.Q));

      // Correction
      this.x = predX + K * (z - (this.C * predX));
      this.cov = predCov - (K * this.C * predCov);
    }

    return this.x;
  }

  predict([u = 0]) {
    return (this.A * this.x) + (this.B * u);
  }

  uncertainty() {
    return ((this.A * this.cov) * this.A) + this.R;
  }

  lastMeasurement() {
    return this.x;
  }

  setMeasurementNoise(noise) {
    this.Q = noise;
  }

  setProcessNoise(noise) {
    this.R = noise;
  }
}
