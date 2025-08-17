import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// 時刻と時間のみのTimeOfDayを年月日のあるFirebase Timestampに変換する
extension TimeOfDayExtension on TimeOfDay {
  // 1970-01-01でTimestamp変換
  Timestamp toTimestamp() {
    final dateTime = DateTime(1970, 1, 1, hour, minute);
    return Timestamp.fromDate(dateTime);
  }

  // 特定の年月日(DateTime)を指定したTimestamp変換
  Timestamp toTimestampWithDate(DateTime date) {
    final dateTime = DateTime(date.year, date.month, date.day, hour, minute);
    return Timestamp.fromDate(dateTime);
  }
}

extension TimestampExtension on Timestamp {
  TimeOfDay toTimeOfDay() {
    final dateTime = toDate();
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }
}
