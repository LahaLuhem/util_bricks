import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/core/abstracts/app_setup.dart';
import 'features/core/abstracts/router/app_router.dart';
import 'features/core/data/constants/const_colours.dart' as custom_app_themes;
import 'features/core/data/constants/const_values.dart';

/// Root entry-point for Dart
Future<void> mainRoot() async {
  await runZonedGuarded(() async {
    await AppSetup.initialise();
    runApp(const App());
  }, AppSetup.onUncaughtException);
}

/// Base app widget
class App extends StatelessWidget {
  ///Constructor
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    builder:
        (context, _) => PlatformApp.router(
          title: ConstValues.appTitle,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          localizationsDelegates: AppSetup.localizationDelegates,
          supportedLocales: AppSetup.supportedLocales,
          material:
              (_, _) => MaterialAppRouterData(
                theme: custom_app_themes.materialLightTheme,
                darkTheme: custom_app_themes.materialDarkTheme,
              ),
          cupertino: (_, _) => CupertinoAppRouterData(theme: custom_app_themes.cupertinoLightTheme),
        ),
  );
}
