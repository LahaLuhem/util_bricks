// ignore_for_file: prefer-match-file-name

import 'package:fpdart/fpdart.dart';

extension OptionalExtensions<T> on Option<T> {
  /// Should only be used after an explicit [isNone] guard.
  T get forceValue => toNullable()!;
}

extension EitherExtension<L, R> on Either<L, R> {
  /// Should only be used after an explicit [isLeft] guard.
  L get forceLeftValue => getLeft().forceValue;

  /// Should only be used after an explicit [isRight] guard.
  R get forceRightValue => getRight().forceValue;
}
