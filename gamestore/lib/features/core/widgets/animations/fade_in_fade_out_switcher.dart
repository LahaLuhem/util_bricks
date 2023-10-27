import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/widgets.dart';

import '/features/core/data/constants/const_durations.dart';

/// Switches in a [Widget] when it is changed, with a Fade Effect.
class FadeInFadeOutSwitcher extends StatelessWidget {
  /// Constructor
  const FadeInFadeOutSwitcher({
    required Widget child,
    bool transformSize = false,
    this.animationDuration = ConstDurations.defaultAnimationDuration,
    super.key,
  })  : _child = child,
        _transformSize = transformSize;

  final Widget _child;
  final bool _transformSize;

  /// Animation timing
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: animationDuration,
      child: AnimatedSwitcher(
        duration: animationDuration,
        transitionBuilder: (child, animation) {
          final animationTween = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(0.15, 1, curve: Curves.easeInOut),
            ),
          );
          return _transformSize
              ? SizeFadeTransition(
                  animation: animationTween,
                  child: child,
                )
              : FadeTransition(
                  opacity: animationTween,
                  child: child,
                );
        },
        child: _child,
      ),
    );
  }
}
