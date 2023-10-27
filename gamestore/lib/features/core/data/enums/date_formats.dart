import 'package:intl/intl.dart';

/// All the [DateFormat]s formats to be used in the app.
enum DateTimeFormats {
  /// (04-20-2009)
  shortDayMonthLongYearHyphens('dd-MM-yyyy'),

  /// (5:30)
  timeOnlyColons('H:m');

  /// Format string
  final String format;

  /// Wrapper for format string
  DateFormat get dateFormat => DateFormat(format);

  const DateTimeFormats(this.format);
}
