import 'dart:io';

import 'package:dio/dio.dart';

///extension
extension ResponseExtension<T> on Response<T> {
  /// Returns whether the received response was successful.
  /// If the response did not have status-code key, then it will return false.
  bool get wasSuccessful => statusCode == HttpStatus.ok;
}
