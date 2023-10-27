import 'dart:async';

import 'package:flutter/material.dart' show Theme;
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/core/abstracts/app_setup.dart';
import 'features/core/abstracts/router/app_router.dart';
import 'features/core/data/constants/const_colours.dart' as custom_app_themes;
import 'features/core/data/constants/const_values.dart';
import 'features/core/data/extensions/context_extensions.dart';

/// Root entry-point for Dart
Future<void> mainRoot() async {
  await runZonedGuarded(
    () async {
      await AppSetup.initialise();
      runApp(const GamestoreApp());
    },
    AppSetup.onUncaughtException,
  );
}

/// Base app widget
class GamestoreApp extends StatelessWidget {
  ///Constructor
  const GamestoreApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, __) => Theme(
        data: platformThemeData(
          context,
          material: (_) => context.isDarkMode
              ? custom_app_themes.materialDarkTheme
              : custom_app_themes.materialLightTheme,
          cupertino: (_) => context.isDarkMode
              ? custom_app_themes.cupertinoThemeDarkHack
              : custom_app_themes.cupertinoThemeLightHack,
        ),
        child: PlatformApp.router(
          title: ConstValues.appTitle,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          localizationsDelegates: AppSetup.localizationDelegates,
          supportedLocales: AppSetup.supportedLocales,
        ),
      ),
    );
  }
}
