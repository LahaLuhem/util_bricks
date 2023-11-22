import 'package:flutter/services.dart';

/// Formatting decimals
class DecimalLengthLimitingTextInputFormatter extends TextInputFormatter {
  /// maximum length of a whole number
  final int maxWholeNumberLength;

  /// maximum length of a floating-point number
  final int maxDecimalNumberLength;

  /// Constructor
  DecimalLengthLimitingTextInputFormatter(
    this.maxWholeNumberLength, [
    this.maxDecimalNumberLength = 2,
  ]) : assert(
          maxWholeNumberLength >= 0 && maxDecimalNumberLength >= 0,
          "Arguments can't be negative",
        );

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(',', '.').trim();
    if (text == '.' || text.isEmpty) {
      return newValue.copyWith(text: newValue.text.replaceAll('.', ',').trim());
    }

    if (!_canParseToDouble(text) || text.contains('-')) return oldValue;

    final splitNumber = text.split('.');
    final wholeNumbers = splitNumber[0];
    String? decimalNumbers;

    if (splitNumber.length > 1) {
      decimalNumbers = splitNumber[1];
    }

    final parsedWholeNumbers = int.tryParse(wholeNumbers)?.toString() ?? '';

    if (parsedWholeNumbers.length > maxWholeNumberLength) return oldValue;
    if (decimalNumbers != null && decimalNumbers.length > maxDecimalNumberLength) {
      return oldValue;
    }

    final newText = parsedWholeNumbers + (decimalNumbers == null ? '' : ',$decimalNumbers');
    final selection = newValue.selection;
    final composing = newValue.composing;

    if (newText == oldValue.text) return oldValue;

    return newValue.copyWith(
      text: newText,
      selection: selection.copyWith(
        baseOffset: selection.baseOffset.clamp(0, newText.length),
        extentOffset: selection.extentOffset.clamp(0, newText.length),
      ),
      composing: TextRange(
        start: composing.start.clamp(0, newText.length),
        end: composing.start.clamp(0, newText.length),
      ),
    );
  }

  bool _canParseToDouble(String value) {
    final formattedValue = value.replaceAll(',', '.');
    return double.tryParse(formattedValue) != null;
  }
}
