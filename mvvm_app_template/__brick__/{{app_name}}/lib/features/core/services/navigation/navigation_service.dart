// _Routers are never used directly
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '/locator.dart';
import '../../abstracts/navigation.dart';
import '../../abstracts/router/app_route.dart';

part 'core_router.dart';
part 'home_router.dart';

/// Provides convenient navigation functions
class NavigationService {
  /// Constructor
  NavigationService() : core = _CoreRouter(), home = _HomeRouter();

  /// Core
  final _CoreRouter core;

  /// Home
  final _HomeRouter home;

  /// Dismisses any pop-up dialogs
  void dismissPopup(BuildContext context) => context.pop();

  /// Close any pop-up dialogs
  void closeModalSheet(BuildContext context) => context.pop();

  /// Locator
  static NavigationService get locate => Locator.locate();
}
