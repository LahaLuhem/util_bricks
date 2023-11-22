import 'dart:async' as async;

///extension
extension FutureExtension<T> on Future<T> {
  /// Decorator instead of wrapper
  void get unawaited => async.unawaited(this);
}
