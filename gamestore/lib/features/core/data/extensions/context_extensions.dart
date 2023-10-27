import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '/l10n/generated/l10n.dart';

/// extension
extension DarkMode on BuildContext {
  /// is dark mode currently enabled?
  ///
  /// Using the context version in release throws exception.
  bool get isDarkMode =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;

  /// Returns the instance of [Strings.current]
  Strings get strings => Strings.current;
}
