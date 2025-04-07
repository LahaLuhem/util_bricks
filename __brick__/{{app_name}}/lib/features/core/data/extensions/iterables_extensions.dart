// ignore_for_file: prefer-match-file-name

extension IterableExtensions<T> on Iterable<T> {
  List<T> insertAlternate({required T element}) => toList().insertAlternate(element: element);

  bool isLast({required int index}) => index == length - 1;

  bool isNotLast({required int index}) => !isLast(index: index);

  /// Worst-case complexity: O(n^2)
  /// If that's too slow, check out preprocessor + KMP algorithm
  bool containsAll(Iterable<T> other) => Set.of(this).containsAll(other);
}

extension ListExtensions<T> on List<T> {
  List<T> get deepCopy => toList();

  List<T> insertAlternate({required T element}) =>
      isEmpty
          ? this
          : List<T>.generate(length * 2 - 1, (index) => index.isEven ? this[index ~/ 2] : element);

  bool get hasSingle => length == 1;

  bool isLast({required int index}) => index == length - 1;

  bool isNotLast({required int index}) => !isLast(index: index);

  void replaceWith(Iterable<T> other) =>
      this
        ..clear()
        ..addAll(other);
}

extension BoolListExtensions<T> on List<bool> {
  bool get allTrue => every((element) => element);
}
