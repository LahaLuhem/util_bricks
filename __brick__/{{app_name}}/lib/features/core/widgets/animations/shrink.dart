// ignore_for_file: prefer-match-file-name

import 'package:flutter/material.dart';

import '../../data/constants/const_durations.dart';

/// Animates the vertical shrinking and fading of its child widgets.
class VerticalShrink extends StatelessWidget {
  /// Main constructor
  const VerticalShrink.showHide({
    required this.show,
    required this.showChild,
    this.fadeDuration = ConstDurations.defaultAnimationDuration,
    this.sizeDuration = ConstDurations.defaultAnimationDuration,
    this.fadeInCurve = Curves.easeInOut,
    this.fadeOutCurve = Curves.easeInOut,
    this.sizeCurve = Curves.easeInOut,
    this.alignment = Alignment.center,
    this.curveIntervalStart = 0.15,
    this.hideChild,
    this.width,
    super.key,
  });

  static final _key = UniqueKey();

  /// The widget to be shown when show is true
  final Widget showChild;

  /// Duration of the fade animation
  final Duration fadeDuration;

  /// Duration of the size (vertical shrink) animation
  final Duration sizeDuration;

  /// Curve for the fade-in animation
  final Curve fadeInCurve;

  /// Curve for the fade-out animation
  final Curve fadeOutCurve;

  /// Curve for the size animation
  final Curve sizeCurve;

  /// Alignment of the child widgets
  final AlignmentGeometry alignment;

  /// Should be shown
  final bool show;

  /// An optional widget to be shown when show is false.
  /// If not provided, a SizedBox with no dimensions is used
  final Widget? hideChild;

  /// The start point of the curve interval for the fade-in animation
  final double curveIntervalStart;

  /// An optional width to be applied to the SizedBox when hideChild is used
  final double? width;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: AnimatedSize(
      duration: sizeDuration,
      curve: sizeCurve,
      alignment: alignment,
      child: AnimatedSwitcher(
        duration: fadeDuration,
        switchInCurve: fadeInCurve,
        switchOutCurve: fadeOutCurve,
        transitionBuilder:
            hideChild != null
                ? (child, animation) => FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Interval(curveIntervalStart, 1, curve: Curves.easeInOut),
                    ),
                  ),
                  child: child,
                )
                : AnimatedSwitcher.defaultTransitionBuilder,
        layoutBuilder: (currentChild, previousChildren) {
          final children = List<Widget>.empty(growable: true);
          if (currentChild != null) {
            if (previousChildren.isEmpty) {
              children.add(currentChild);
            } else {
              children.addAll([
                Positioned(left: 0, right: 0, child: previousChildren.first),
                currentChild,
              ]);
            }
          }

          return Stack(
            clipBehavior: Clip.none,
            alignment: alignment,
            children: children.isNotEmpty ? children : previousChildren,
          );
        },
        child:
            show
                ? showChild
                : (hideChild ?? SizedBox(key: _key, width: width ?? double.infinity, height: 0)),
      ),
    ),
  );
}

/// Animates the horizontal shrinking and fading of its child widgets.
class HorizontalShrink extends StatelessWidget {
  /// Main constructor
  const HorizontalShrink.showHide({
    required this.show,
    required this.showChild,
    this.fadeDuration = ConstDurations.defaultAnimationDuration,
    this.sizeDuration = ConstDurations.defaultAnimationDuration,
    this.fadeInCurve = Curves.easeInOut,
    this.fadeOutCurve = Curves.easeInOut,
    this.sizeCurve = Curves.easeInOut,
    this.alignment = Alignment.center,
    this.hideChild,
    this.height,
    super.key,
  });

  static final _key = UniqueKey();

  /// The widget to be shown when show is true
  final Widget showChild;

  /// Duration of the fade animation
  final Duration fadeDuration;

  /// Duration of the size (vertical shrink) animation
  final Duration sizeDuration;

  /// Curve for the fade-in animation
  final Curve fadeInCurve;

  /// Curve for the fade-out animation
  final Curve fadeOutCurve;

  /// Curve for the size animation
  final Curve sizeCurve;

  /// Alignment of the child widgets
  final AlignmentGeometry alignment;

  /// Should be shown
  final bool show;

  /// An optional widget to be shown when show is false.
  /// If not provided, a SizedBox with no dimensions is used
  final Widget? hideChild;

  /// An optional width to be applied to the SizedBox when hideChild is used
  final double? height;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: AnimatedSize(
      duration: sizeDuration,
      curve: sizeCurve,
      alignment: alignment,
      child: AnimatedSwitcher(
        duration: fadeDuration,
        switchInCurve: fadeInCurve,
        layoutBuilder: (currentChild, previousChildren) {
          final children = List<Widget>.empty(growable: true);
          if (currentChild != null) {
            if (previousChildren.isEmpty) {
              children.add(currentChild);
            } else {
              children.addAll([
                Positioned(top: 0, bottom: 0, child: previousChildren.first),
                currentChild,
              ]);
            }
          }

          return Stack(
            clipBehavior: Clip.none,
            alignment: alignment,
            children: children.isNotEmpty ? children : previousChildren,
          );
        },
        switchOutCurve: fadeOutCurve,
        child:
            show
                ? showChild
                : (hideChild ?? SizedBox(key: _key, width: 0, height: height ?? double.infinity)),
      ),
    ),
  );
}
