import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Complete store of all definitions for all kinds of fields for forms
class FormFieldConfig {
  /// Constructor
  FormFieldConfig({
    this.hintText,
    this.textEditingController,
    this.focusNode,
    ValueListenable<bool>? isEnabledListenable,
  }) : isEnabledListenable = isEnabledListenable ?? ValueNotifier(true);

  /// Hint for a field
  final String? hintText;

  /// Field controller
  final TextEditingController? textEditingController;

  /// Focus definition
  final FocusNode? focusNode;

  /// Field enabled
  final ValueListenable<bool> isEnabledListenable;
}
