import 'dart:core';

/// Config for positioning method
abstract class PositioningConfig {}

mixin Positioning {
  /// Init the positioning method
  void init(PositioningConfig config);
}
