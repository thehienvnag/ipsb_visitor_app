import 'package:flutter/material.dart';

class MapMarker {
  final double dx, dy;
  final Widget content;
  MapMarker({
    required this.dx,
    required this.dy,
    required this.content,
  });
  @override
  String toString() {
    return '($dx, $dy)';
  }
}
