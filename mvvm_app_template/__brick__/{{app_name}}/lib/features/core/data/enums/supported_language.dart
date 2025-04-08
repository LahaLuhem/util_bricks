/// languages supported by the app
enum SupportedLanguage {
  /// English
  en,

  /// Dutch
  nl,
}

///extension
extension SupportedLanguagesExtension on String? {
  /// Resolves the default supported language
  SupportedLanguage get toSupportedLanguage => SupportedLanguage.values.firstWhere(
    (element) => element.name == this?.trim().toLowerCase(),
    orElse: () => SupportedLanguage.en,
  );
}
