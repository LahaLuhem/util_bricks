extension NumExtensions on num {
  bool get isPositive => this >= 0;
}

extension DoubleExtensions on double {
  double get withoutRoundingErrors => (this * 100).round() / 100;

  // !SHOULD ONLY BE USED FOR THE `tallyPieces` LOCALIZATION STRING!
  // TODO(Mehul): find a way to combine plurality and NumberFormatterPattern in the ARB file
  num get toWholeNumber => this % 1 == 0 ? toInt() : this;
}
