// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '/l10n/generated/l10n.dart';
import '../data/enums/view_model_state.dart';
import '../services/logging_service.dart';

/// Base class for a View Model
abstract class BaseViewModel<E extends Object?> extends ChangeNotifier {
  final ValueNotifier<bool> _isInitialised = ValueNotifier(false);

  /// initialized
  ValueListenable<bool> get isInitialised => _isInitialised;

  final ValueNotifier<bool> _isBusy = ValueNotifier(false);

  /// busy
  ValueListenable<bool> get isBusy => _isBusy;

  final ValueNotifier<bool> _hasError = ValueNotifier(false);

  /// has error
  ValueListenable<bool> get hasError => _hasError;

  final ValueNotifier<ViewModelState> _state = ValueNotifier(ViewModelState.isInitialising);

  /// VM state
  ValueListenable<ViewModelState> get state => _state;

  /// All possible [Listenable]s.
  List<ValueListenable<bool>> get stateListenables => [
        _isInitialised,
        _isBusy,
        _hasError,
      ];

  @protected
  // ignore: public_member_api_docs
  final loggingService = LoggingService.locate;

  String? _errorMessage;

  /// Error message
  String get errorMessage => _errorMessage ?? Strings.current.somethingWentWrong;

  /// Setup before ViewModel is ready
  /// [disposableBuildContext] provides a temporary [BuildContext] that should not be used further.
  /// [mounted] is a callback for indicating a successful frame mount.
  /// [arguments] That need to be passed to the VM.
  @mustCallSuper
  void initialise(BuildContext disposableBuildContext, bool Function() mounted, [E? arguments]) {
    isMounted = mounted;
    _isInitialised.value = true;
    _state.value = ViewModelState.isInitialised;

    loggingService.successfulInit(location: runtimeType.toString());
  }

  /// Set _isInitialised.
  // ignore: use_setters_to_change_properties
  void setInitialised(bool isInitialised) => _isInitialised.value = isInitialised;

  /// Set state as busy
  void setBusy(bool isBusy) {
    _isBusy.value = isBusy;
    if (isBusy) {
      _state.value = ViewModelState.isBusy;
    } else {
      _state.value = ViewModelState.isInitialised;
    }
  }

  /// Set state as error
  void setError(bool hasError, {String? message}) {
    _errorMessage = hasError ? message : null;
    _hasError.value = hasError;
    if (hasError) {
      _state.value = ViewModelState.hasError;
    } else {
      _state.value = ViewModelState.isInitialised;
    }
  }

  @override
  void dispose() {
    super.dispose();

    loggingService.successfulDispose(location: runtimeType.toString());
  }

  /// isMounted
  late final bool Function() isMounted;

  /// Callback for after successful mount.
  void ifMounted(VoidCallback voidCallback) {
    if (isMounted()) {
      voidCallback();
    }
  }

  /// Awaits the [future], while setting [isBusy] and releasing it after completion.
  Future<T> runBusyFuture<T>(Future<T> future) async {
    try {
      setBusy(true);
      return await future;
    } catch (e) {
      rethrow;
    } finally {
      setBusy(false);
    }
  }

  /// Callback to be executed after the widget tree is fully built and mounted
  void addPostFrameCallback(FrameCallback frameCallback) =>
      WidgetsBinding.instance.addPostFrameCallback(frameCallback);
}
