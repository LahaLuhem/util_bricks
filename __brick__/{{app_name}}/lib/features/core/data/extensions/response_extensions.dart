// ignore_for_file: prefer-match-file-name

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../services/logging_service.dart';

final _loggingService = LoggingService.locate;

extension ResponseExtension<T> on Response<T> {
  bool get isNotOk => statusCode != HttpStatus.ok;
}

extension ResponseGuardExtension<T> on Task<Response<T>> {
  /// Can be used for most basic API-fetch-return cases
  TaskOption<T> runGuardedApiCall({
    required String Function(T data)? successLogMessage,
    required String errorLogMessage,
    required void Function(T fetchedData)? onFetchDataSuccess,
  }) => runGuardedApiCallCustomTransform(
    successLogMessage: successLogMessage,
    errorLogMessage: errorLogMessage,
    successTransformer: (fetchedData) {
      onFetchDataSuccess?.call(fetchedData);

      return TaskOption.some(fetchedData);
    },
  );

  /// Use when the type of data needs to be transformed after success fetch.
  TaskOption<M> runGuardedApiCallCustomTransform<M>({
    required String Function(T data)? successLogMessage,
    required String errorLogMessage,
    required TaskOption<M> Function(T fetchedData) successTransformer,
  }) => TaskOption<T>(() async {
    final Response<T> response;
    try {
      response = await run();
    } on Exception catch (ex, stackTrace) {
      _loggingService.logException(ex, stackTrace, errorLogMessage);

      return none();
    }
    if (response.isNotOk) {
      _loggingService.logError('$errorLogMessage: ${response.statusCode}');

      return none();
    }

    final fetchedData = response.data as T;
    if (successLogMessage != null) {
      _loggingService.logSuccess(successLogMessage.call(fetchedData));
    }

    return some(fetchedData);
  }).flatMap(successTransformer);
}

extension TupleResponseGuardExtension<T1, T2> on Task<(Response<T1>, Response<T2>)> {
  /// Simplified version for when you just need both successful responses
  TaskOption<(T1, T2)> runGuardedApiCall({
    required String Function(T1 data1, T2 data2)? successLogMessage,
    required String errorLogMessage,
    required void Function(T1 data1, T2 data2)? onFetchDataSuccess,
  }) => runGuardedApiCallCustomTransform(
    successLogMessage: successLogMessage,
    errorLogMessage: errorLogMessage,
    successTransformer: (data1, data2) {
      onFetchDataSuccess?.call(data1, data2);

      return TaskOption.some((data1, data2));
    },
  );

  /// Full version with custom transformation
  TaskOption<M> runGuardedApiCallCustomTransform<M>({
    required String Function(T1 data1, T2 data2)? successLogMessage,
    required String errorLogMessage,
    required TaskOption<M> Function(T1 data1, T2 data2) successTransformer,
  }) => TaskOption<(T1, T2)>(() async {
    final (Response<T1>, Response<T2>) responses;
    try {
      responses = await run();
    } on Exception catch (ex, stackTrace) {
      final parallelWaitError = ex as ParallelWaitError;
      if (ex is ParallelWaitError) {
        _loggingService.logError(
          '$errorLogMessage -> ${parallelWaitError.errors}',
          parallelWaitError,
          parallelWaitError.stackTrace,
        );
      } else {
        _loggingService.logException(ex, stackTrace, errorLogMessage);
      }

      return none();
    }
    final response1 = responses.$1;
    final response2 = responses.$2;
    if (response1.isNotOk || response2.isNotOk) {
      _loggingService.logError(
        '$errorLogMessage (Status: ${response1.statusCode}, ${response2.statusCode})',
      );

      return none();
    }

    final data1 = response1.data as T1;
    final data2 = response2.data as T2;

    if (successLogMessage != null) {
      _loggingService.logSuccess(successLogMessage(data1, data2));
    }

    return some((data1, data2));
  }).flatMap((data) => successTransformer(data.$1, data.$2));
}

extension ListResponseGuardExtension<T> on Task<List<Response<T>>> {
  /// Simplified version for when you need all successful responses in a list
  TaskOption<List<T>> runGuardedApiCall({
    required String Function(List<T> data)? successLogMessage,
    required String errorLogMessage,
    required void Function(List<T> fetchedData)? onFetchDataSuccess,
  }) => runGuardedApiCallCustomTransform(
    successLogMessage: successLogMessage,
    errorLogMessage: errorLogMessage,
    successTransformer: (dataList) {
      onFetchDataSuccess?.call(dataList);

      return TaskOption.some(dataList);
    },
  );

  /// Full version with custom transformation
  TaskOption<M> runGuardedApiCallCustomTransform<M>({
    required String Function(List<T> data)? successLogMessage,
    required String errorLogMessage,
    required TaskOption<M> Function(List<T> dataList) successTransformer,
  }) => TaskOption<List<T>>(() async {
    final List<Response<T>> responses;
    try {
      responses = await run();
    } on Exception catch (ex, stackTrace) {
      if (ex is ParallelWaitError) {
        final parallelWaitError = ex as ParallelWaitError;
        _loggingService.logError(
          '$errorLogMessage -> ${parallelWaitError.errors}',
          parallelWaitError,
          parallelWaitError.stackTrace,
        );
      } else {
        _loggingService.logException(ex, stackTrace, errorLogMessage);
      }

      return none();
    }

    if (responses.any((r) => r.isNotOk)) {
      final statusCodes = responses.map((r) => r.statusCode).join(', ');
      _loggingService.logError('$errorLogMessage (Statuses: $statusCodes)');

      return none();
    }
    final dataList = responses.map((r) => r.data as T).toList();

    if (successLogMessage != null) {
      _loggingService.logSuccess(successLogMessage(dataList));
    }

    return some(dataList);
  }).flatMap(successTransformer);
}
