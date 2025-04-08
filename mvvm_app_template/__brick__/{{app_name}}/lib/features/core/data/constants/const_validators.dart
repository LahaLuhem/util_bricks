import 'package:flutter/widgets.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '/l10n/generated/l10n.dart';

/// Validation functions
abstract class ConstValidators {
  /// Defines multiple [FormFieldValidator]s to be checked
  static FormFieldValidator<T> multiple<T>(List<FormFieldValidator<T>> validators) =>
      FormBuilderValidators.compose(validators);

  /// Prevents a field from sending null ot empty values
  static FormFieldValidator<T> required<T>({String? errorText}) => (valueCandidate) {
    if (valueCandidate == null || valueCandidate is String && valueCandidate.trim().isEmpty) {
      return errorText ?? Strings.current.formFieldRequired.toUpperCase();
    }

    return null;
  };

  /// Local-aware wrapper for [FormBuilderValidators.notZeroNumber].
  static FormFieldValidator<T> notZeroNumber<T>() => (valueCandidate) {
    final num? value;
    final errorText = FormBuilderLocalizations.current.notZeroNumberErrorText;

    if (valueCandidate is String) {
      value = NumberFormat().tryParse(valueCandidate);
    } else if (valueCandidate is num) {
      value = valueCandidate;
    } else {
      return errorText;
    }

    if (value == null || value == 0) return errorText;

    return null;
  };
}
