// ignore_for_file: prefer-match-file-name

import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

extension FieldExtension on GlobalKey<FormBuilderState> {
  FormBuilderFieldState<FormBuilderField<T>, T>? formBuilderField<T>({required String fieldName}) =>
      currentState?.fields[fieldName] as FormBuilderFieldState<FormBuilderField<T>, T>?;
}
