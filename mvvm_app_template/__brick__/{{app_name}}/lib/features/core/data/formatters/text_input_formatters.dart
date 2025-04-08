import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../data/enums/supported_phone_number.dart';

/// Text input formatters
abstract class TextInputFormatters {
  /// Formats input to only allow for numbers.
  static TextInputFormatter numbers([int? maxLength]) =>
      TextInputFormatter.withFunction((oldValue, newValue) {
        if ((maxLength != null && maxLength >= newValue.text.length) || maxLength == null) {
          final newText = newValue.text;
          final isNumeric = RegExp(r'^-?[0-9]+$');

          /// check if the string contains only numbers
          return newText.isEmpty || isNumeric.hasMatch(newText) ? newValue : oldValue;
        } else {
          return oldValue;
        }
      });

  /// Formats into lowercase
  static TextInputFormatter lowerCase() => TextInputFormatter.withFunction(
    (oldValue, newValue) => newValue.copyWith(text: newValue.text.toLowerCase()),
  );

  /// Formats into uppercase
  static TextInputFormatter upperCase() => TextInputFormatter.withFunction(
    (oldValue, newValue) => newValue.copyWith(text: newValue.text.toUpperCase()),
  );

  /// Strips country codes from the beginning of text.
  ///
  /// Stripping happens only WHEN the country-code has been typed.
  static TextInputFormatter phoneNumber({
    required ValueListenable<SupportedPhoneNumber> supportedPhoneNumber,
  }) => TextInputFormatter.withFunction((_, newValue) {
    final sanitizedText = newValue.text
        // Remove ANY occurring spaces
        .replaceAll(r'\s', '')
        // Remove custom characters
        .replaceAll(RegExp(r'[()\[\]]'), '')
        // Remove country-code and any other abbreviations
        .replaceFirst(RegExp('^(\\${supportedPhoneNumber.value.countryPhoneCode}|0)'), '');

    final replaceLength = newValue.text.length - sanitizedText.length;

    return replaceLength == 0
        ? newValue
        : newValue.copyWith(
          text: sanitizedText,
          selection: newValue.selection.copyWith(
            baseOffset: sanitizedText.length,
            extentOffset: sanitizedText.length,
          ),
        );
  });
}
