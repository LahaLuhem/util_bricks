import 'package:flutter/widgets.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '/l10n/generated/l10n.dart';

/// Validation functions
abstract class ConstValidators {
  /// Defines multiple [FormFieldValidator]s to be checked
  static FormFieldValidator<dynamic> multiple(List<FormFieldValidator<dynamic>> validators) =>
      FormBuilderValidators.compose(validators);

  /// Prevents a field from sending null ot empty values
  static FormFieldValidator<T> required<T>() {
    return (T? valueCandidate) {
      if (valueCandidate == null || valueCandidate is String && valueCandidate.trim().isEmpty) {
        return Strings.current.formFieldRequired.toUpperCase();
      }
      return null;
    };
  }
}
