///extension
extension ListExtensions<T> on List<T> {
  /// Creates an unaliased deep copy
  List<T> get deepCopy => [...this];

  /// Create an [List.unmodifiable] from given list
  List<T> get unmodifiable => List<T>.unmodifiable(this);

  /// Removes the last object in this list iff the list is not empty
  void removeLastSafely() {
    if (isNotEmpty) removeLast();
  }
}
