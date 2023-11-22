import 'dart:io';

import '/features/core/data/typedefs/http_status_code.dart';
import '/features/core/services/logging_service.dart';
import '/locator.dart';

/// Responsible for authentication
class AuthService {
  /// Constructor
  AuthService();

  final _loggingService = LoggingService.locate;

  /// (On success): Sets the received [AuthDTO] and returns a [HttpStatus.ok]
  ///
  /// (on Failures): Auth failed -> [HttpStatus.forbidden]<br>
  /// No data for account -> [HttpStatus.noContent]<br>
  /// Any other exceptions encountered -> [HttpStatus.serviceUnavailable]
  Future<HttpStatusCode> login({
    required String username,
    required String password,
  }) async {
    _loggingService.info('Sending logging credentials');

    _loggingService.info('Received auth response from the mavis client');

    throw UnimplementedError('Implement me!');
  }

  /// Handles logout
  Future<void> logout() async {
    throw UnimplementedError('Implement me!');
  }

  /// Locator DI
  static AuthService get locate => Locator.locate();
}
