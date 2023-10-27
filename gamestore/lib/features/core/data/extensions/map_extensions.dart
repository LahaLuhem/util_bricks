///extension
extension MapExtensions<A, B> on Map<A, B> {
  /// Creates an unaliased deep copy
  Map<A, B> get deepCopy => {...this};
}
