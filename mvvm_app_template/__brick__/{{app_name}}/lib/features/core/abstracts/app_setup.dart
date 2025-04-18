import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:intl/date_symbol_data_local.dart';

import '/l10n/generated/l10n.dart';
import '/locator.dart';
import '../data/enums/supported_language.dart';

/// Handles setting up of the app.
abstract class AppSetup {
  /// Initializes everything before the app is run.
  static Future<void> initialise() async {
    WidgetsFlutterBinding.ensureInitialized();

    await [
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]),
      Firebase.initializeApp(),
      initializeDateFormatting(),
      setupStrings(),
    ].wait;

    await Locator.setup();
  }

  /// Resolves the supported locales
  static List<Locale> get supportedLocales =>
      kReleaseMode
          ? <Locale>[
            for (final languageCode in SupportedLanguage.values)
              Locale.fromSubtags(languageCode: languageCode.name),
          ]
          : Strings.delegate.supportedLocales;

  /// Resolves localization delegates
  // ignore: avoid-dynamic
  static Iterable<LocalizationsDelegate<dynamic>> get localizationDelegates => const [
    ...AppLocalizations.localizationsDelegates,
    Strings.delegate,
    FormBuilderLocalizations.delegate,
  ];

  /// Sets up strings for the correct locale.
  static Future<void> setupStrings() => Strings.load(
    _resolveLocale(
      preferredLocales: PlatformDispatcher.instance.locales,
      supportedLocales: supportedLocales,
    ),
  );

  static Locale _resolveLocale({
    required Iterable<Locale> supportedLocales,
    List<Locale>? preferredLocales,
  }) {
    for (final locale in preferredLocales ?? const <Locale>[]) {
      // Check if the current device locale is supported
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return supportedLocale;
        }
      }
    }

    return supportedLocales.first;
  }

  /// Callback for any missed exception
  static void Function(Object error, StackTrace stackTrace) get onUncaughtException =>
      (error, stackTrace) => FirebaseCrashlytics.instance.recordError(
        'Location: Zoned | Unhandled exception caught: $error',
        stackTrace,
      );
}
