import 'package:flutter/cupertino.dart' show CupertinoFormSection, CupertinoTextFormFieldRow;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show InputDecoration, TextFormField;
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../data/enums/form_field_type.dart';
import '../forms/form_field_config.dart';

/// Standard form
class PlatformCustomForm extends StatelessWidget {
  /// Constructor
  const PlatformCustomForm({required this.fields, super.key});

  /// Fields to be included inside the form.
  final Map<FormFieldType, FormFieldConfig> fields;

  @override
  Widget build(BuildContext context) => FormBuilder(
    child: PlatformWidget(
      material:
          (context, _) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                for (final field in fields.entries)
                  ValueListenableBuilder<bool>(
                    valueListenable: field.value.isEnabledListenable,
                    builder:
                        (context, isEnabled, _) => TextFormField(
                          decoration: InputDecoration(labelText: field.value.hintText),
                          obscureText: field.key == FormFieldType.password,
                          controller: field.value.textEditingController,
                          enabled: isEnabled,
                        ),
                  ),
              ],
            ),
          ),
      cupertino:
          (context, _) =>
              fields.length == 1
                  ? _ListenableCupertinoTextFormField(
                    field: fields.entries.first,
                    isEnabledListenable: fields.entries.first.value.isEnabledListenable,
                  )
                  : CupertinoFormSection.insetGrouped(
                    children: [
                      for (final field in fields.entries)
                        _ListenableCupertinoTextFormField(
                          field: field,
                          isEnabledListenable: field.value.isEnabledListenable,
                        ),
                    ],
                  ),
    ),
  );
}

class _ListenableCupertinoTextFormField extends StatelessWidget {
  const _ListenableCupertinoTextFormField({required this.field, required this.isEnabledListenable});

  final MapEntry<FormFieldType, FormFieldConfig> field;
  final ValueListenable<bool> isEnabledListenable;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
    valueListenable: field.value.isEnabledListenable,
    builder:
        (context, isEnabled, _) => CupertinoTextFormFieldRow(
          prefix: Text(field.value.hintText ?? ''),
          obscureText: field.key == FormFieldType.password,
          controller: field.value.textEditingController,
          enabled: isEnabled,
        ),
  );
}
