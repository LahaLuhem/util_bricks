// ignore_for_file: sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

export 'package:cloud_firestore/cloud_firestore.dart';

/// Conversion between [DateTime] and Firestore's [Timestamp].
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);

  /// const Constructor
  const TimestampConverter();
}

/// Nullable variant of [TimestampConverter].
class TimestampConverterNullable implements JsonConverter<DateTime?, Timestamp?> {
  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) => object != null ? Timestamp.fromDate(object) : null;

  /// const Constructor
  const TimestampConverterNullable();
}
