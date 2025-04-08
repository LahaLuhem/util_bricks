// ignore_for_file: library_private_types_in_public_api, prefer-match-file-name

import 'package:flutter/widgets.dart';

/// Provider for Animation controller
class AnimationControllerProvider extends StatefulWidget {
  /// Constructor
  const AnimationControllerProvider({
    required this.builder,
    double? value,
    Duration? duration,
    Duration? reverseDuration,
    String? debugLabel,
    double lowerBound = 0.0,
    double upperBound = 1.0,
    AnimationBehavior animationBehavior = AnimationBehavior.normal,
    bool repeatAnimation = true,
    super.key,
  }) : _value = value,
       _duration = duration,
       _reverseDuration = reverseDuration,
       _debugLabel = debugLabel,
       _lowerBound = lowerBound,
       _upperBound = upperBound,
       _animationBehavior = animationBehavior,
       _repeatAnimation = repeatAnimation;

  ///Builder
  final Widget Function(BuildContext context, AnimationController animationController) builder;

  final double? _value;
  final Duration? _duration;
  final Duration? _reverseDuration;
  final String? _debugLabel;
  final double _lowerBound;
  final double _upperBound;
  final AnimationBehavior _animationBehavior;
  final bool _repeatAnimation;

  @override
  _AnimationControllerProviderState createState() => _AnimationControllerProviderState();
}

class _AnimationControllerProviderState extends State<AnimationControllerProvider>
    with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    value: widget._value,
    duration: widget._duration,
    reverseDuration: widget._reverseDuration,
    debugLabel: widget._debugLabel,
    lowerBound: widget._lowerBound,
    upperBound: widget._upperBound,
    animationBehavior: widget._animationBehavior,
  );

  @override
  void initState() {
    if (widget._repeatAnimation) {
      _animationController.addStatusListener(_repeatListener);
    }
    super.initState();
  }

  void _repeatListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.stop();
    if (widget._repeatAnimation) {
      _animationController.removeStatusListener(_repeatListener);
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _animationController);
}
