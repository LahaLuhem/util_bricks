import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// This widget listens to multiple [ValueListenable]s and calls given builder function
/// if any one of them changes.
class MultiValueListenableBuilder extends StatelessWidget {
  /// Constructor
  const MultiValueListenableBuilder({
    required this.valueListenables,
    required this.builder,
    this.child,
    super.key,
  }) : assert(
          valueListenables.length != 0,
          'Attached valueListenables must not be empty',
        );

  /// List of [ValueListenable]s to be listened to.
  final List<ValueListenable<dynamic>> valueListenables;

  /// The builder function to be called when value of any of the [ValueListenable] changes.
  /// The order of values list will be same as [valueListenables] list.
  final Widget Function(BuildContext context, List<dynamic> values, Widget? child) builder;

  /// An optional child widget which will be available as child parameter in [builder].
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(valueListenables),
      builder: (context, child) {
        final providedValues = valueListenables.map((listenable) => listenable.value);
        return builder(
          context,
          List<dynamic>.unmodifiable(providedValues),
          child,
        );
      },
      child: child,
    );
  }
}
