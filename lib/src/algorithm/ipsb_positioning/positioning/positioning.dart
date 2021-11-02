import 'dart:core';

/// Config for positioning method
abstract class PositioningConfig {
  double mapScale;
  PositioningConfig({
    required this.mapScale,
  });
}

mixin Positioning {
  /// Init the positioning method
  void init(PositioningConfig config);
}
