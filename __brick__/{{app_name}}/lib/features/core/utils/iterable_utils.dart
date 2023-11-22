/// Allows for parallel iteration
/// Synonymous to the `zip` function in Python
class Pair<A, B> {
  /// Constructor
  const Pair(this.a, this.b);

  /// Iterable 1
  final A a;

  /// Iterable 2
  final B b;
}

/// Zips up the given Iterables for parallel iteration, and yielding
Iterable<Pair<A, B>> zip<A, B>(List<A> listA, List<B> listB) sync* {
  assert(
    listA.length == listB.length,
    'For zipping, lengths of the lists must match',
  );
  for (var i = 0; i < listA.length; i++) {
    yield Pair(listA[i], listB[i]);
  }
}
