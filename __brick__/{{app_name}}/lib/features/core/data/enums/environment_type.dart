import 'package:flutter/widgets.dart';

import '/env/env_config.dart';
import 'supported_language.dart';

/// Defines the app flavours/environments in use
enum EnvironmentType {
  /// Development
  dev,

  /// Live
  live;

  /// Override and sets up the environment-specific configuration
  void override() => EnvConfig(environmentType: this);

  /// Resolves the current app language
  static SupportedLanguage currentLanguage(BuildContext context) =>
      Localizations.localeOf(context).languageCode.toSupportedLanguage;
}
