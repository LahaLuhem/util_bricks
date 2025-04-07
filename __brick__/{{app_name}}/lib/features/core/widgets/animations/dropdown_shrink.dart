import 'package:flutter/widgets.dart';

import '/features/core/data/constants/core_constants.dart';

/// Creates a shrink animation for a dropdown.
class DropdownShrink extends StatelessWidget {
  /// Main constructor
  const DropdownShrink.showHide({
    required this.show,
    required this.child,
    required this.clipFieldRadius,
    required this.clipPadding,
    super.key,
    this.fadeDuration = ConstDurations.defaultAnimationDuration,
    this.sizeDuration = ConstDurations.defaultAnimationDuration,
    this.fadeInCurve = Curves.easeInOut,
    this.fadeOutCurve = Curves.easeInOut,
    this.sizeCurve = Curves.easeInOut,
    this.alignment = Alignment.center,
    this.hide,
    this.width,
  });

  static final _key = UniqueKey();

  /// Child
  final Widget child;

  /// Fade [Duration]
  final Duration fadeDuration;

  /// Size change animation [Duration]
  final Duration sizeDuration;

  /// Curve definition for fade-in
  final Curve fadeInCurve;

  /// Curve definition for fade-out
  final Curve fadeOutCurve;

  /// Curve definition for resizing
  final Curve sizeCurve;

  /// Alignment property.
  final AlignmentGeometry alignment;

  /// Whether to show the content
  final bool show;

  /// Widget to hide with
  final Widget? hide;

  /// Width of the dropdown
  final double? width;

  /// Radial distance from the clip
  final double clipFieldRadius;

  /// Clip padding
  final EdgeInsets clipPadding;

  @override
  Widget build(BuildContext context) => ClipPath(
    clipper: _DropdownClipper(fieldRadius: clipFieldRadius, padding: clipPadding),
    child: AnimatedSize(
      duration: sizeDuration,
      curve: sizeCurve,
      alignment: alignment,
      child: AnimatedSwitcher(
        duration: fadeDuration,
        switchInCurve: fadeInCurve,
        switchOutCurve: fadeOutCurve,
        transitionBuilder:
            hide != null
                ? (child, animation) => FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: const Interval(0.15, 1, curve: Curves.easeInOut),
                    ),
                  ),
                  child: child,
                )
                : AnimatedSwitcher.defaultTransitionBuilder,
        layoutBuilder: (currentChild, previousChildren) {
          var children = previousChildren;
          if (currentChild != null) {
            children =
                previousChildren.isEmpty
                    ? [currentChild]
                    : [Positioned(left: 0, right: 0, child: previousChildren.first), currentChild];
          }

          return Stack(clipBehavior: Clip.none, alignment: alignment, children: children);
        },
        child:
            show
                ? child
                : (hide ?? SizedBox(key: _key, width: width ?? double.infinity, height: 0)),
      ),
    ),
  );
}

class _DropdownClipper extends CustomClipper<Path> {
  const _DropdownClipper({required this.padding, required this.fieldRadius});

  final EdgeInsets padding;
  final double fieldRadius;

  @override
  Path getClip(Size size) =>
      Path()
        ..moveTo(fieldRadius, 0)
        ..relativeQuadraticBezierTo(-fieldRadius, 0, -fieldRadius, -fieldRadius)
        ..lineTo(0, 0)
        ..lineTo(-padding.left, 0)
        ..lineTo(-padding.left, size.height + padding.bottom)
        ..lineTo(size.width + padding.right, size.height + padding.bottom)
        ..lineTo(size.width + padding.right, -fieldRadius)
        ..lineTo(size.width, -fieldRadius)
        ..relativeQuadraticBezierTo(0, fieldRadius, -fieldRadius, fieldRadius)
        ..close();

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
