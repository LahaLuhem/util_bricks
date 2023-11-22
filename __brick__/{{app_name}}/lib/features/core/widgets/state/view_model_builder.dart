import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '/features/core/abstracts/base_view_model.dart';
import '../../data/constants/const_durations.dart';
import '../animations/fade_in_fade_out_switcher.dart';

/// Builds the bridge between a View and the View Model
class ViewModelBuilder<T extends BaseViewModel> extends StatefulWidget {
  /// Builds the bridge between a View and the View Model
  const ViewModelBuilder({
    required Widget Function(BuildContext context, T model) builder,
    required T Function() viewModelBuilder,
    required BuildContext disposableBuildContext,
    dynamic Function()? argumentBuilder,
    Widget? loadingIndicator,
    super.key,
  })  : _builder = builder,
        _viewModelBuilder = viewModelBuilder,
        _argumentBuilder = argumentBuilder,
        _loadingIndicator = loadingIndicator,
        _disposableBuildContext = disposableBuildContext;

  final Widget Function(BuildContext context, T model) _builder;
  final T Function() _viewModelBuilder;
  final dynamic Function()? _argumentBuilder;

  final Widget? _loadingIndicator;
  final BuildContext _disposableBuildContext;

  @override
  // ignore: library_private_types_in_public_api
  _ViewModelBuilderState<T> createState() => _ViewModelBuilderState<T>();
}

class _ViewModelBuilderState<T extends BaseViewModel> extends State<ViewModelBuilder<T>> {
  late final T _viewModel;

  @override
  void initState() {
    _viewModel = widget._viewModelBuilder();
    _viewModel.initialise(
      widget._disposableBuildContext,
      () => mounted,
      widget._argumentBuilder?.call(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _) => ChangeNotifierProvider.value(
        value: _viewModel,
        child: Consumer<T>(
          builder: (context, model, _) => ValueListenableBuilder<bool>(
            valueListenable: _viewModel.isInitialised,
            builder: (context, isInitialised, _) => FadeInFadeOutSwitcher(
              animationDuration: ConstDurations.oneAndHalfDefaultAnimationDuration,
              child: isInitialised
                  ? widget._builder(context, model)
                  : Center(
                      child: widget._loadingIndicator ?? PlatformCircularProgressIndicator(),
                    ),
            ),
          ),
        ),
      );
}
