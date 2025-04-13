import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../data/constants/const_keys.dart';
import '../../data/extensions/core_extensions.dart';
import '../../data/models/app_settings_model.dart';
import '../storage_service.dart';

// import 'hive_registrar.g.dart';

part 'hive_custom_adapters.dart';
// part 'hive_storage_service.g.dart';

@Singleton(as: StorageService, signalsReady: true)
@GenerateAdapters([])
class HiveStorageService extends StorageService {
  final FlutterSecureStorage _flutterSecureStorage;

  static const _appSettingsBoxKey = 'deviceSettingsKey';

  late final Box<AppSettingsModel> _appSettingsBox;

  HiveStorageService({required FlutterSecureStorage flutterSecureStorage})
    : _flutterSecureStorage = flutterSecureStorage {
    _initialise().unawaited;
  }

  Future<void> _initialise() async {
    await Hive.initFlutter();
    // Hive.registerAdapters();
    // _overrideCustomAdapters();

    // Encrypted boxes
    //ignore: unused_local_variable
    final loadedEncryptionKey = await _encryptionKey();

    // Normal boxes
    _appSettingsBox = await Hive.openBox(_appSettingsBoxKey);

    GetIt.instance.signalReady(this);
    signalInitDone();
  }

  ///////////////////////////////  APP SETTINGS  ///////////////////////////////
  @override
  Option<AppSettingsModel> deviceSettingsForUser({required int userId}) =>
      Option.fromNullable(_appSettingsBox.get(userId));

  @override
  Future<void> upsertDeviceSettings({required int userId}) async {
    final updatedHiveSettings =
        _appSettingsBox.get(userId)?.copyWith(userId: userId) ?? AppSettingsModel(userId: userId);

    await _appSettingsBox.put(userId, updatedHiveSettings);
    logDebug('updated Hive Device settings for user($userId) with $updatedHiveSettings');
  }

  ///////////////////////////////  UTILITIES  ///////////////////////////////

  Future<List<int>> _encryptionKey() async {
    final encodedEncryptionKeyOrNone = Option.fromNullable(
      await _flutterSecureStorage.read(key: ConstKeys.hiveEncryptionKey),
    );

    return encodedEncryptionKeyOrNone.fold(() async {
      final encryptionKey = Hive.generateSecureKey();
      await _flutterSecureStorage.write(
        key: ConstKeys.hiveEncryptionKey,
        value: base64UrlEncode(encryptionKey),
      );

      return encryptionKey;
    }, (encodedEncryptionKey) => base64Url.decode(encodedEncryptionKey));
  }

  // void _overrideCustomAdapters() {
  //   Hive
  //     ..registerAdapter(_V117EmployeeAdapter(), override: true)
  //     ..registerAdapter(_V113EmployeeSettingsAdapter(), override: true);
  // }
}

@module
abstract class RegisterFlutterSecureStorageModule {
  @singleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage();
}
