import 'package:flutter/widgets.dart';

extension TextControllerExtensions on TextEditingController {
  void selectAllText() {
    if (text.isNotEmpty) {
      selection = TextSelection(baseOffset: text.length, extentOffset: 0);
    }
  }
}
