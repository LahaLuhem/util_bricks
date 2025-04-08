import 'dart:async';

import 'package:flutter/foundation.dart';

mixin AsyncInitMixin {
  var _initCompleter = Completer<void>();

  @nonVirtual
  Future<void> get initAwaiter => _initCompleter.future;

  @protected
  @nonVirtual
  void signalInitDone() => _initCompleter.complete();

  @protected
  @nonVirtual
  void signalInitError(Object error, [StackTrace? stackTrace]) =>
      _initCompleter.completeError(error, stackTrace);

  @protected
  @nonVirtual
  void signalReinitIfDone() {
    if (_initCompleter.isCompleted) {
      _initCompleter = Completer<void>();
    }
  }
}
