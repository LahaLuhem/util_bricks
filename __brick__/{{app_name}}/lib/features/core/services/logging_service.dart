import 'dart:io';

import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

import '/locator.dart';

/// Logs important events
class LoggingService {
  final Talker _talker = Talker(
    // observer: _CrashlyticsObserver(),
    settings: TalkerSettings(
      useHistory: false,
    ),
    logger: TalkerLogger(
      formatter: !Platform.isIOS ? const ColoredLoggerFormatter() : const ExtendedLoggerFormatter(),
      settings: TalkerLoggerSettings(
        enableColors: !Platform.isIOS,
      ),
    ),
  );

  /// Successful critical event
  void Function(dynamic msg, [Object? exception, StackTrace? stackTrace]) get good => _talker.good;

  /// Common/general event
  void Function(dynamic msg, [Object? exception, StackTrace? stackTrace]) get info =>
      _talker.verbose;

  /// Non-fatal but important/recovered event
  void Function(dynamic msg, [Object exception, StackTrace stackTrace]) get warning =>
      _talker.warning;

  /// Fatal and important recorded event
  void Function(dynamic msg, [Object? exception, StackTrace? stackTrace]) get error =>
      _talker.error;

  /// Initialised successfully
  /// Generally reserved for ViewModels
  void successfulInit({required String location}) =>
      _talker.good('[$location] 📚 I am initialized');

  /// Disposed successfully
  /// Generally reserved for ViewModels
  void successfulDispose({required String location}) =>
      _talker.good('[$location] 🗑 I am disposed');

  /// Adds logging to dio calls
  void addLoggingInterceptor({
    required Dio dio,
    required TalkerDioLoggerSettings? talkerDioLoggerSettings,
  }) {
    dio.interceptors.add(
      TalkerDioLogger(
        talker: Talker(
          logger: TalkerLogger(formatter: const ColoredLoggerFormatter()),
          settings: TalkerSettings(
            useHistory: false,
          ),
        ),
        settings: talkerDioLoggerSettings ??
            const TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printResponseHeaders: true,
            ),
      ),
    );
  }

  /// Locates for DI
  static LoggingService get locate => Locator.locate();
}

// class _CrashlyticsObserver implements TalkerObserver {
//   final crashlyticsInstance = FirebaseCrashlytics.instance;
//
//   @override
//   void onLog(TalkerDataInterface talkerLog) =>
//       crashlyticsInstance.log('[${talkerLog.title}] | ${talkerLog.displayMessage}');
//
//   @override
//   void onError(TalkerError talkerError) => crashlyticsInstance.recordError(
//         talkerError.error,
//         talkerError.stackTrace,
//         reason: '[${talkerError.title}]\n${talkerError.displayMessage}',
//         fatal: true,
//       );
//
//   @override
//   void onException(TalkerException talkerException) => crashlyticsInstance.recordError(
//         talkerException.exception,
//         talkerException.stackTrace,
//         reason: '[${talkerException.title}]\n${talkerException.displayMessage}',
//         fatal: true,
//       );
// }
