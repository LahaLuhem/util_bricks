// ignore_for_file: avoid-dynamic
// Many signature matching for child libraries that use dynamic themselves
// ignore_for_file: avoid_annotating_with_dynamic

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

import '/locator.dart';

mixin class LoggingService {
  static final _talker = Talker(
    observer: kReleaseMode ? _CrashlyticsObserver() : null,
    settings: TalkerSettings(
      useHistory: false,
      colors: {TalkerLogType.verbose.key: AnsiPen()..green()},
    ),
    logger: TalkerLogger(
      formatter: const ColoredLoggerFormatter(),
      settings: TalkerLoggerSettings(
        enableColors: !Platform.isIOS,
        colors: {LogLevel.verbose: AnsiPen()..green()},
      ),
    ),
  );

  void logSuccess(dynamic msg, [Object? exception, StackTrace? stackTrace]) =>
      _talker.verbose('✅ $msg', exception, stackTrace);

  void logDebug(dynamic msg, [Object? exception, StackTrace? stackTrace]) =>
      _talker.debug('🐛 $msg', exception, stackTrace);

  void logNote(dynamic msg, [Object? exception, StackTrace? stackTrace]) =>
      _talker.info('☝️ $msg', exception, stackTrace);

  void logWarning(dynamic msg, [Object? exception, StackTrace? stackTrace]) =>
      _talker.warning('🚧 $msg', exception, stackTrace);

  void logError(dynamic msg, [Object? exception, StackTrace? stackTrace]) =>
      _talker.error('❌ $msg', exception, createStackTrace(stackTrace: stackTrace));

  void logException(Object exception, [StackTrace? stackTrace, dynamic msg]) =>
      _talker.handle(exception, createStackTrace(stackTrace: stackTrace), '❌ $msg');

  void logVmInit({required String vmName}) => logSuccess('${vmName}ViewModel 📚 I am initialized');

  void logVmDispose({required String vmName}) => logSuccess('${vmName}ViewModel 🗑 I am disposed');

  static StackTrace createStackTrace({required StackTrace? stackTrace}) {
    StackTrace localStackTrace;
    try {
      localStackTrace =
          stackTrace ??
              StackTrace.fromString(StackTrace.current.toString().split('\n').sublist(1).join('\n'));
    } on Exception catch (_) {
      localStackTrace = StackTrace.current;
    }

    return localStackTrace;
  }

  /// Adds logging to dio calls
  static void addLoggingInterceptor({required Dio dio}) {
    dio.interceptors.add(
      TalkerDioLogger(
        talker: Talker(
          logger: TalkerLogger(formatter: const ColoredLoggerFormatter()),
          settings: TalkerSettings(useHistory: false),
        ),
        settings: const TalkerDioLoggerSettings(printRequestData: false, printResponseData: false),
      ),
    );
  }

  static LoggingService get locate => Locator.locate();
}

class _CrashlyticsObserver implements TalkerObserver {
  final crashlyticsInstance = FirebaseCrashlytics.instance;

  @override
  void onError(TalkerError talkerError) => crashlyticsInstance.recordError(
    talkerError.error,
    talkerError.stackTrace,
    reason: talkerError.displayMessage,
  );

  @override
  void onException(TalkerException talkerException) => crashlyticsInstance.recordError(
    talkerException.exception,
    talkerException.stackTrace,
    reason: talkerException.displayMessage,
  );

  @override
  void onLog(TalkerData talkerLog) =>
      crashlyticsInstance.log('[${talkerLog.title}] | ${talkerLog.displayMessage}');
}
