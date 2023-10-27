import 'package:flutter/services.dart';

/// Formatting for whole numbers
class WholeNumberLengthLimitingTextInputFormatter extends TextInputFormatter {
  /// maximum length of number
  final int maxNumbers;

  /// Constructor
  WholeNumberLengthLimitingTextInputFormatter(
    this.maxNumbers,
  ) : assert(maxNumbers >= 0, "Argument can't be negative");

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.trim();
    if (text.isEmpty) return newValue.copyWith(text: text);

    if (text.length > maxNumbers || text.contains(RegExp(r'[\D]'))) return oldValue;

    final parsed = int.tryParse(text);

    if (parsed == null) return oldValue;

    final selection = newValue.selection;
    final parsedString = parsed.toString();
    return newValue.copyWith(
      text: parsedString,
      selection: selection.copyWith(
        baseOffset: selection.baseOffset.clamp(0, parsedString.length),
        extentOffset: selection.extentOffset.clamp(0, parsedString.length),
      ),
    );
  }
}
