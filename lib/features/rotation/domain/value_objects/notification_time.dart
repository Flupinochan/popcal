import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

extension type NotificationTime(TimeOfDay value) {
  // 現在時刻取得用
  factory NotificationTime.now() {
    final now = DateTime.now();
    return NotificationTime(TimeOfDay(hour: now.hour, minute: now.minute));
  }

  // 表示用
  String get display24hour =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  Timestamp get timestamp =>
      Timestamp.fromDate(DateTime(1970, 1, 1, value.hour, value.minute));
}
