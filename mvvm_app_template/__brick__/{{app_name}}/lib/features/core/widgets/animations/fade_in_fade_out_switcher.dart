import 'package:flutter/widgets.dart';

import '/features/core/data/constants/core_constants.dart';

/// An [AnimatedSwitcher] that uses a custom transitionBuilder, that also allows for defining a [_transformSize].
class FadeInFadeOutSwitcher extends StatelessWidget {
  final Widget _child;
  final bool _transformSize;

  /// Animation timing
  final Duration duration;

  /// Constructor
  const FadeInFadeOutSwitcher({
    required Widget child,
    bool transformSize = false,
    this.duration = ConstDurations.defaultAnimationDuration,
    super.key,
  }) : _child = child,
       _transformSize = transformSize;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    duration: duration,
    transitionBuilder: (child, animation) {
      final animationTween = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animation, curve: const Interval(0.15, 1, curve: Curves.easeInOut)),
      );

      return _transformSize
          ? FadeTransition(
            opacity: animationTween,
            child: SizeTransition(sizeFactor: animationTween, child: child),
          )
          : FadeTransition(opacity: animationTween, child: child);
    },
    child: _child,
  );
}
