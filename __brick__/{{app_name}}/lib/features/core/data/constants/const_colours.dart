// ignore_for_file: public_member_api_docs

import 'dart:ui';

import 'package:flutter/cupertino.dart' show CupertinoColors, CupertinoThemeData;
import 'package:flutter/material.dart' show CardTheme, Color, ThemeData;
import 'package:flutter/painting.dart';

import 'ui/const_sizes.dart';

/// Colours and themes
abstract class ConstColours {
  static const vampireBlack = Color(0xFF050505);
  static const indigoDye = Color(0xFF171C8F);
  static const orangeRed = Color(0xFFFF671F);

  static const transparent = Color(0x00000000);
  static const white = Color(0xFFFFFFFF);
  static const darkSilver = Color(0xFF707070);

  static const cupertinoBackground = CupertinoColors.systemBackground;
  static const cupertinoBackgroundGrouped = CupertinoColors.systemGroupedBackground;
  static const cupertinoBackgroundGroupedSecondary =
      CupertinoColors.secondarySystemGroupedBackground;

  static const cupertinoActiveGreen = CupertinoColors.activeGreen;
  static const cupertinoActiveOrange = CupertinoColors.activeOrange;
  static const cupertinoDestructiveRed = CupertinoColors.destructiveRed;
}

ThemeData get materialLightTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorSchemeSeed: ConstColours.indigoDye,
      cardTheme: const CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: ConstSizes.genericCurvatureBorderRadius,
        ),
        elevation: ConstSizes.defaultElevation,
      ),
    );

ThemeData get materialDarkTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: ConstColours.indigoDye,
    );

CupertinoThemeData get cupertinoLightTheme => const CupertinoThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      // primaryColor: ConstColours.indigoDye,
      // primaryContrastingColor: ConstColours.orangeRed,
    );

CupertinoThemeData get cupertinoDarkTheme => const CupertinoThemeData(
      brightness: Brightness.dark,
      // primaryColor: ConstColours.indigoDye,
      // primaryContrastingColor: ConstColours.orangeRed,
    );

ThemeData get cupertinoThemeLightHack =>
    materialLightTheme.copyWith(cupertinoOverrideTheme: cupertinoLightTheme);

ThemeData get cupertinoThemeDarkHack =>
    materialDarkTheme.copyWith(cupertinoOverrideTheme: cupertinoDarkTheme);
