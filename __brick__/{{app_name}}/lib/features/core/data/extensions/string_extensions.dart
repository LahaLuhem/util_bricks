// ignore_for_file: prefer-match-file-name

import 'package:flutter/widgets.dart';

extension StringExtension on String {
  String capitalize() => isNotEmpty ? '${this[0].toUpperCase()}${characters.getRange(1)}' : this;
}

extension NullableStringExtesions on String? {
  String? nullIfEmpty() => this?.isNotEmpty ?? false ? this : null;
}

extension StringTemplateExension on String {
  /// Define placeholder text in this format: `'Today is %1\$ and tomorrow is %2\$'`
  /// Usage: 'text.insertPlaceholders([replacements]: ['Monday', 'Tuesday'])'
  String insertPlaceholders({required List<String> replacements}) {
    var result = this;
    for (var i = 1; i < replacements.length + 1; i++) {
      result = result.replaceAll('%$i\$', replacements[i - 1]);
    }

    return result;
  }
}
