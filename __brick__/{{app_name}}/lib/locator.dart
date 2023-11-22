import 'dart:async';

import 'package:get_it/get_it.dart';

import 'features/auth/services/auth_service.dart';
import 'features/core/services/logging_service.dart';
import 'features/core/services/navigation/navigation_service.dart';
import 'features/core/views/home/home_view_model.dart';

/// Locates dependency for DI
GetIt get locate => Locator.instance();

/// Dependency Injection
class Locator {
  /// Instance of [GetIt]
  static GetIt instance() => GetIt.instance;

  /// Callback for performing a DI lookup
  static T locate<T extends Object>() => instance().get<T>();

  /// Set up of all DI registrations
  static Future<void> setup() async {
    final locator = instance()..registerFactory(LoggingService.new);

    _registerStores(locator);
    _registerAPIs(locator);
    _registerViewModels(locator);
    _registerLazySingletons();
    _registerFactories();

    await _registerDaos(locator);
    await _registerServices(locator);

    await _registerRepos(locator);
    await _registerBlocs(locator);

    _registerSingletons();
  }

  static void _registerAPIs(GetIt it) {}

  static void _registerLazySingletons() {}

  static void _registerSingletons() {}

  static void _registerFactories() {}

  static void _registerStores(GetIt it) {}

  static Future<void> _registerBlocs(GetIt it) async {}

  static Future<void> _registerDaos(GetIt it) async {}

  static Future<void> _registerRepos(GetIt it) async {}

  static Future<void> _registerServices(GetIt it) async {
    it
      ..registerLazySingleton(AuthService.new)
      ..registerLazySingleton(NavigationService.new);
  }

  static void _registerViewModels(GetIt it) {
    it.registerFactory(
      () => HomeViewModel(
        authService: AuthService.locate,
        navigationService: NavigationService.locate,
      ),
    );
  }
}
