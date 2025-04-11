# slang_translate

## Generating
Run the `-o` flag should point to the project's root directory (where the 'lib' folder is)

## Other source code changes
Look at the documentation of [Slang](https://pub.dev/packages/slang), and ensure that the base setup is complete. This may include:
1. Adding `await LocaleSettings.useDeviceLocale();` to the `AppSetup`
2. App changes
    1. Wrap the your `App` in a `TranslationProvider`.
    2. Use `locale: TranslationProvider.of(context).flutterLocale`
    3. Use `supportedLocales: AppLocaleUtils.supportedLocales`
3. Start using it with `strings` variable.