// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Provides a model to a widget and rebuilds when notifyListeners is called.
///
/// Do keep in mind that you need to have the model in the context,
/// so only use these widgets inside the views of the view models
/// where the view model is present.
abstract class ViewModelWidget<T> extends Widget {
  /// Constructor
  const ViewModelWidget({super.key});

  /// Build abstract method
  @protected
  Widget build(BuildContext context, T model);

  @override
  _DataProviderElement<T> createElement() => _DataProviderElement<T>(this);
}

class _DataProviderElement<T> extends ComponentElement {
  _DataProviderElement(ViewModelWidget<T> super.widget);

  @override
  ViewModelWidget<T> get widget => super.widget as ViewModelWidget<T>;

  @override
  Widget build() => widget.build(this, Provider.of<T>(this));

  @override
  void update(ViewModelWidget<T> newWidget) {
    super.update(newWidget);
    assert(widget == newWidget, 'widget is the same as newWidget');
    rebuild();
  }
}
