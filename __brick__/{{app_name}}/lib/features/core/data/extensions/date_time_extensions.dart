// ignore_for_file: prefer-match-file-name

import 'package:intl/intl.dart';

import '../enums/date_time_format.dart';

extension DateTimeExtension on DateTime {
  String inFormat({required DateTimeFormat dateTimeFormat}) =>
      DateFormat(dateTimeFormat.format).format(this);

  DateTime get dayStart => DateTime(year, month, day);

  DateTime get monthStart => DateTime(year, month);
}
