import 'package:flutter/widgets.dart';

extension WidgetExtensions on Widget {
  Padding moveWithVKeyboard(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: this,
  );
}
