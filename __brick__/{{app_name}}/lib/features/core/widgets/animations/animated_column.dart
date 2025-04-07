import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/constants/const_durations.dart';

/// [AnimatedColumn] Animates its children when they get added or removed,
/// at its end.
class AnimatedColumn extends StatelessWidget {
  /// Constructor
  const AnimatedColumn({
    required this.children,
    this.duration = ConstDurations.defaultAnimationDuration,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 0,
    super.key,
  });

  /// [duration] specifies the duration of the add/remove animation
  final Duration duration;

  /// [Column] property
  final MainAxisAlignment mainAxisAlignment;

  /// [Column] property
  final MainAxisSize mainAxisSize;

  /// [Column] property
  final CrossAxisAlignment crossAxisAlignment;

  final double spacing;

  /// [Column] property
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: mainAxisSize,
    mainAxisAlignment: mainAxisAlignment,
    crossAxisAlignment: crossAxisAlignment,
    spacing: spacing,
    children: children
        .animate(interval: ConstDurations.halfDefaultAnimationDuration)
        .fade(duration: duration),
  );
}
