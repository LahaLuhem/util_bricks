import '/features/core/data/typedefs/http_status_code_extension.dart';
import '/features/core/services/logging_service.dart';
import '/locator.dart';

/// Responsible for authentication
@lazySingleton
class AuthService with LoggingService {
  /// Constructor
  AuthService();

  Future<HttpStatusCode> login({required String username, required String password}) {
    logDebug('Sending logging credentials');
    logDebug('Received auth response from the mavis client');

    throw UnimplementedError('Implement me!');
  }

  /// Handles logout
  Future<void> logout() {
    throw UnimplementedError('Implement me!');
  }
}
