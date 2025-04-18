import 'package:flutter/material.dart' show Colors;
import 'package:flutter/painting.dart';

/// Defines the shadow for layering
abstract class ConstBoxShadows {
  /// Default
  static BoxShadow get defaultShadow =>
      BoxShadow(color: Colors.black.withAlpha(25), offset: const Offset(0, 4), blurRadius: 5);

  /// Lowest elevation
  static List<BoxShadow> get elevation3 => [
    BoxShadow(color: Colors.black.withAlpha(31), blurRadius: 4, offset: const Offset(0, 3)),
    BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 3, offset: const Offset(3, 3)),
    BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 8, offset: const Offset(0, 1)),
  ];

  /// Medium elevation
  static List<BoxShadow> get elevation4 => [
    BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 5, offset: const Offset(0, 4)),
    BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10, offset: const Offset(0, 1)),
    BoxShadow(color: Colors.black.withAlpha(31), blurRadius: 4, offset: const Offset(0, 2)),
  ];
}
