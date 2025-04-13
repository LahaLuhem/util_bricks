// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'features/auth/services/auth_service.dart' as _i620;
import 'features/core/services/hive/hive_storage_service.dart' as _i511;
import 'features/core/services/logging_service.dart' as _i969;
import 'features/core/services/storage_service.dart' as _i568;
import 'features/core/views/home/home_view_model.dart' as _i104;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerFlutterSecureStorageModule =
        _$RegisterFlutterSecureStorageModule();
    gh.factory<_i969.LoggingService>(() => _i969.LoggingService());
    gh.singleton<_i558.FlutterSecureStorage>(
      () => registerFlutterSecureStorageModule.flutterSecureStorage,
    );
    gh.lazySingleton<_i620.AuthService>(() => const _i620.AuthService());
    gh.singleton<_i568.StorageService>(
      () => _i511.HiveStorageService(
        flutterSecureStorage: gh<_i558.FlutterSecureStorage>(),
      ),
      signalsReady: true,
    );
    gh.factory<_i104.HomeViewModel>(
      () => _i104.HomeViewModel(authService: gh<_i620.AuthService>()),
    );
    return this;
  }
}

class _$RegisterFlutterSecureStorageModule
    extends _i511.RegisterFlutterSecureStorageModule {}
