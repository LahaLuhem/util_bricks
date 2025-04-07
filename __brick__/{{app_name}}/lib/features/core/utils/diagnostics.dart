import 'package:flutter/foundation.dart';

mixin Diagnostics {
  final Map<String, DateTime> _logTimestamps = {};

  void initDiagnostics(String key) {
    _logTimestamps[key] = DateTime.now();
  }

  void printDiagnostics(String key) {
    final timestamp = _logTimestamps[key];
    if (timestamp == null) {
      debugPrint('No timestamp found for $key');

      return;
    }

    final now = DateTime.now();
    final diff = now.difference(timestamp);
    debugPrint('Time elapsed for $key: $diff');
  }
}
