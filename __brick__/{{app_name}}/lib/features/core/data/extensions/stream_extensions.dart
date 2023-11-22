import 'package:flutter/foundation.dart';

///extension
extension StreamExtensions<T> on Stream<T> {
  /// Convert to a [ValueListenable].
  ValueListenable<T> toValueNotifier(
    T initialValue, {
    bool Function(T previous, T current)? notifyWhen,
  }) {
    final notifier = ValueNotifier<T>(initialValue);
    listen((value) {
      if (notifyWhen == null || notifyWhen(notifier.value, value)) {
        notifier.value = value;
      }
    });
    return notifier;
  }

  /// Convert to a [ValueListenable]?.
  ValueListenable<T?> toNullableValueNotifier({
    bool Function(T? previous, T? current)? notifyWhen,
  }) {
    final notifier = ValueNotifier<T?>(null);
    listen((value) {
      if (notifyWhen == null || notifyWhen(notifier.value, value)) {
        notifier.value = value;
      }
    });
    return notifier;
  }

  /// Convert to a [Listenable].
  Listenable toListenable() {
    final notifier = ChangeNotifier();
    listen((_) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      notifier.notifyListeners();
    });
    return notifier;
  }
}
