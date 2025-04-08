import 'dart:io';

/// Special int as an HttpStatusCode
typedef HttpStatusCode = int;

/// extension
extension HttpStatusCodeExtension on HttpStatusCode {
  /// Whether the received status was [HttpStatus.ok]
  bool get wasSuccessful => this == HttpStatus.ok;
}
