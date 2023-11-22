import 'package:intl/intl.dart';

import '../enums/date_formats.dart';

/// Extensions on [DateTime].
extension DateTimeExtensions on DateTime {
  /// Formats given [DateTime] into a [String], according to [dateTimeFormat] format.
  String inFormat({required DateTimeFormats dateTimeFormat}) =>
      DateFormat(dateTimeFormat.format).format(this);

  /// Start of actual new day
  DateTime get dayStart => DateTime(year, month, day);

  /// Returns whether 2 [DateTime]s are on the same day of the year, ignoring time.
  bool isSameDateAs(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
