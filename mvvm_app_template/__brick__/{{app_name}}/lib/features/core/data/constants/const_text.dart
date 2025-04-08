import 'package:flutter/painting.dart';

import 'const_colours.dart';

/// Wrapper for standard [TextStyle]s.
abstract class ConstText {
  static const _roboto = 'Roboto';

  /// Level-1 header
  static const header1 = TextStyle(
    color: ConstColours.white,
    fontSize: 20,
    fontFamily: _roboto,
    fontWeight: FontWeight.bold,
    height: 16 / 20,
    letterSpacing: 0,
  );

  /// Level-2 header
  static const header2 = TextStyle(
    color: ConstColours.white,
    fontSize: 14,
    fontFamily: _roboto,
    fontWeight: FontWeight.normal,
    height: 17 / 14,
    letterSpacing: 0,
  );

  /// Tab-label
  static const tab = TextStyle(
    fontSize: 16,
    fontFamily: _roboto,
    height: 19 / 16,
    letterSpacing: 0,
  );

  /// Level-1 body
  static const body1 = TextStyle(
    color: ConstColours.vampireBlack,
    fontSize: 14,
    fontFamily: _roboto,
    fontWeight: FontWeight.w400,
    height: 17 / 14,
    letterSpacing: 0,
  );

  /// Level-1 body with a link
  static TextStyle get bodyLink1 => body1.copyWith(
    fontWeight: FontWeight.w600,
    color: ConstColours.darkSilver,
    decoration: TextDecoration.underline,
  );

  /// Destructive action (red) for iOS
  static const cupertinoDestructiveAction = TextStyle(color: ConstColours.cupertinoDestructiveRed);
}
