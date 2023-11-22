///extension
extension ObjectExtensions on Object? {
  /// Syntactic sugar for explicit type-casting
  E asType<E>() => this as E;
}

///extension
extension AsCallback<T extends Object> on T {
  /// Syntactic sugar for creating a lazy-evaluation
  T Function() get asCallback => () => this;
}
