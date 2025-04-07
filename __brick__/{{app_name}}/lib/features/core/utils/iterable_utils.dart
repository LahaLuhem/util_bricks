/// Allows for parallel iteration
/// Synonymous to the `zip` function in Python
library;
// ignore_for_file: prefer-match-file-name

class Pair<A, B> {
  const Pair(this.a, this.b);

  /// Iterable 1
  final A a;

  /// Iterable 2
  final B b;
}

class Trio<A, B, C> {
  const Trio(this.a, this.b, this.c);

  /// Iterable 1
  final A a;

  /// Iterable 2
  final B b;

  /// Iterable 3
  final C c;
}

/// Zips up the given Iterables for parallel iteration, and yielding
/// Only to be used when the lengths of the data-sources do not change after creation, because 'lazy'
/// Use [zipEager] otherwise
Iterable<Pair<A, B>> zipLazy<A, B>(List<A> listA, List<B> listB) sync* {
  assert(listA.length == listB.length, 'For zipping, lengths of the lists must match');
  for (var i = 0; i < listA.length; i++) {
    yield Pair(listA[i], listB[i]);
  }
}

/// [zipEager] works the same way as [zipLazy], but the grouping computation is done eagerly.
List<Pair<A, B>> zipEager<A, B>(List<A> listA, List<B> listB) {
  assert(listA.length == listB.length, 'For zipping, lengths of the lists must match');

  return [for (var i = 0; i < listA.length; i++) Pair(listA[i], listB[i])];
}

Iterable<A> unzipA<A, B>(Iterable<Pair<A, B>> zippedIterable) =>
    zippedIterable.map((pair) => pair.a);

Iterable<B> unzipB<A, B>(Iterable<Pair<A, B>> zippedIterable) =>
    zippedIterable.map((pair) => pair.b);

/// Zips up the given Iterables for parallel iteration, and yielding
Iterable<Trio<A, B, C>> zip3<A, B, C>(List<A> listA, List<B> listB, List<C> listC) sync* {
  assert(
    listA.length == listB.length && listB.length == listC.length,
    'For zipping, lengths of the lists must match',
  );
  for (var i = 0; i < listA.length; i++) {
    yield Trio(listA[i], listB[i], listC[i]);
  }
}
