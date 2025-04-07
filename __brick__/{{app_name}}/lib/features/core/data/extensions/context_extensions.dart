import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:go_router/go_router.dart';

import '/l10n/generated/l10n.dart';

/// extension
extension ContextExtensions on BuildContext {
  /// Returns the instance of [Strings.current]
  Strings get strings => Strings.current;

  bool get isIOS => isCupertino(this);

  bool get isAndroid => isMaterial(this);

  void tryPop<T extends Object?>([T? result]) {
    if (canPop()) pop(result);
  }

  bool get isVKeyboardOpen => MediaQuery.of(this).viewInsets.bottom != 0;

  T platformValue<T>({required T material, required T cupertino}) => !isIOS ? material : cupertino;

  T? platformValueNullable<T>({T? material, T? cupertino}) => !isIOS ? material : cupertino;
}
