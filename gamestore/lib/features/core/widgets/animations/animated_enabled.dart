import 'package:flutter/widgets.dart';

import '../../data/constants/const_durations.dart';
import '../../data/constants/ui/const_opacities.dart';

/// Switches the enabled/disabled state of child with animation.
class AnimatedEnabled extends StatelessWidget {
  /// Constructor
  const AnimatedEnabled({
    required this.isEnabled,
    required this.child,
    this.animationDuration = ConstDurations.defaultAnimationDuration,
    super.key,
  });

  /// Current state of [child].
  final bool isEnabled;

  /// Child
  final Widget child;

  /// Animation duration
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
        opacity: isEnabled ? 1 : ConstOpacities.defaultDisabled,
        duration: animationDuration,
        curve: Curves.easeInOut,
        child: IgnorePointer(
          ignoring: !isEnabled,
          child: child,
        ),
      );
}
