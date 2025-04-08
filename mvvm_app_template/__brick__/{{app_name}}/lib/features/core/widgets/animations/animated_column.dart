import 'package:flutter/widgets.dart';

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
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.maxAnimatingChildren = 2,
    super.key,
  });

  /// [duration] specifies the duration of the add/remove animation
  final Duration duration;

  /// [maxAnimatingChildren] determines the maximum number of chidren that can
  /// be animating at once, if more are removed or added at within an animation
  /// duration they will pop in instead
  final int maxAnimatingChildren;

  /// [Column] property
  final MainAxisAlignment mainAxisAlignment;

  /// [Column] property
  final MainAxisSize mainAxisSize;

  /// [Column] property
  final CrossAxisAlignment crossAxisAlignment;

  /// [Column] property
  final TextDirection? textDirection;

  /// [Column] property
  final VerticalDirection verticalDirection;

  /// [Column] property
  final TextBaseline? textBaseline;

  /// [Column] property
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: crossAxisAlignment,
    children: [
      for (int i = 0; i < children.length + maxAnimatingChildren; i++)
        AnimatedSwitcher(
          duration: duration,
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder:
              (child, animation) => FadeTransition(
                opacity: animation,
                child: SizeTransition(sizeFactor: animation, axisAlignment: -1, child: child),
              ),
          child: i < children.length ? children[i] : const SizedBox.shrink(),
        ),
    ],
  );
}
