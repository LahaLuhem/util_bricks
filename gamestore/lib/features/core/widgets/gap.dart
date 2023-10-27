// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Create constant size based on parent layout.
class Gap extends LeafRenderObjectWidget {
  /// Constructor
  const Gap(this.size, {super.key});

  /// Pixel-size
  final double size;

  @override
  _RenderGap createRenderObject(BuildContext context) => _RenderGap(size);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderGap renderObject,
  ) {
    renderObject.gap = size;
    super.updateRenderObject(context, renderObject);
  }

  /// 4 pixels
  static const size4 = Gap(4);

  /// 8 pixels
  static const size8 = Gap(8);

  /// 16 pixels
  static const size16 = Gap(16);

  /// 24 pixels
  static const size24 = Gap(24);

  /// 32 pixels
  static const size32 = Gap(32);

  /// 48 pixels
  static const size48 = Gap(48);

  /// 64 pixels
  static const size64 = Gap(64);
}

class _RenderGap extends RenderBox {
  _RenderGap(this._gap) : super() {
    markNeedsLayout();
  }

  double _gap;
  double get gap => _gap;

  set gap(double value) {
    if (_gap != value) {
      _gap = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final parent = this.parent;
    Size newSize;
    if (parent is RenderFlex) {
      switch (parent.direction) {
        case Axis.vertical:
          newSize = Size(0, gap);
        case Axis.horizontal:
          newSize = Size(gap, 0);
      }
    } else {
      newSize = Size.square(gap);
    }
    size = constraints.constrain(newSize);
  }
}

/// Animated version of the [Gap] widget.
class AnimatedGap extends StatefulWidget {
  /// Constructor
  const AnimatedGap(
    this.gap, {
    super.key,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  });

  /// Time of animation
  final Duration duration;

  /// Pixel size
  final double gap;

  /// Rate of change of animation
  final Curve curve;

  @override
  State<AnimatedGap> createState() => _AnimatedGapState();
}

class _AnimatedGapState extends State<AnimatedGap> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    value: widget.gap,
  );

  @override
  void didUpdateWidget(covariant AnimatedGap oldWidget) {
    if (oldWidget.gap != widget.gap) {
      _controller.animateTo(
        widget.gap,
        curve: widget.curve,
        duration: widget.duration,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Gap(_controller.value);
      },
    );
  }
}

/// An [SliverGap] that can be used inside of a [RenderSliver].
class SliverGap extends LeafRenderObjectWidget {
  /// Constructor
  const SliverGap(this.gap, {super.key});

  /// Pixel size
  final double gap;

  /// 4 pixels
  static const size4 = SliverGap(4);

  /// 8 pixels
  static const size8 = SliverGap(8);

  /// 16 pixels
  static const size16 = SliverGap(16);

  /// 24 pixels
  static const size24 = SliverGap(24);

  /// 32 pixels
  static const size32 = SliverGap(32);

  /// 48 pixels
  static const size48 = SliverGap(48);

  /// 64 pixels
  static const size64 = SliverGap(64);

  @override
  _RenderSliverGap createRenderObject(BuildContext context) => _RenderSliverGap(gap);

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderSliverGap renderObject,
  ) {
    renderObject.gap = gap;
    super.updateRenderObject(context, renderObject);
  }
}

class _RenderSliverGap extends RenderSliver {
  _RenderSliverGap(this._gap) : super() {
    markNeedsLayout();
  }

  double _gap;

  double get gap => _gap;

  set gap(double value) {
    if (_gap != value) {
      _gap = value;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    final cacheExtent = calculateCacheOffset(constraints, from: 0, to: gap);
    final paintExtent = calculatePaintOffset(constraints, from: 0, to: gap);
    geometry = SliverGeometry(
      paintExtent: paintExtent,
      scrollExtent: gap,
      visible: false,
      cacheExtent: cacheExtent,
      maxPaintExtent: gap,
    );
  }
}

/// An [AnimatedGap] that can be used inside of a [RenderSliver].
class AnimatedSliverGap extends StatefulWidget {
  /// Constructor
  const AnimatedSliverGap(
    this.gap, {
    super.key,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  });

  /// Time of animation
  final Duration duration;

  /// Pixel size
  final double gap;

  /// Rate of change of animation
  final Curve curve;

  @override
  State<AnimatedSliverGap> createState() => _AnimatedSliverGapState();
}

class _AnimatedSliverGapState extends State<AnimatedSliverGap> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  late final _gapTween = Tween<double>(
    begin: 0,
    end: widget.gap,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedSliverGap oldWidget) {
    if (oldWidget.gap != widget.gap) {
      _gapTween
        ..begin = oldWidget.gap
        ..end = widget.gap;
      _controller
        ..reset()
        ..forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final gap = _gapTween.evaluate(_controller);
        return SliverGap(gap);
      },
    );
  }
}
