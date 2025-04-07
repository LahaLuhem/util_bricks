import 'dart:async' as async;

extension FutureExtensions<T> on Future<T> {
  void get unawaited => async.unawaited(this);
}
