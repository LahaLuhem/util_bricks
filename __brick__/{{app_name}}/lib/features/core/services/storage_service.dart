import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '/locator.dart';
import '../data/mixins/async_init_mixin.dart';
import '../data/models/app_settings_model.dart';
import 'logging_service.dart';

abstract class StorageService with LoggingService, AsyncInitMixin {
  ///////////////////////////////  APP SETTINGS  ///////////////////////////////
  Option<AppSettingsModel> deviceSettingsForUser({required int userId});

  Future<void> upsertDeviceSettings({required int userId});

  ///////////////////////////////  UTILITIES  ///////////////////////////////

  static StorageService get locate => Locator.locate();
}
