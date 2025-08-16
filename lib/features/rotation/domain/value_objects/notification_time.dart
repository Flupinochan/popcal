import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_time.freezed.dart';
part 'notification_time.g.dart';

/// TimeOfDayはfreezedサポート対象外のため、intのhourとminuteを組み合わせることにする
@freezed
sealed class NotificationTime with _$NotificationTime {
  @Deprecated('NotificationTime.fromTimeOfDayを使用してインスタンスを生成してください')
  const factory NotificationTime({
    required int hour,
    required int minute,
  }) = _NotificationTime;

  factory NotificationTime.fromJson(Map<String, dynamic> json) =>
      _$NotificationTimeFromJson(json);

  // TimeOfDayから生成
  factory NotificationTime.fromTimeOfDay(TimeOfDay timeOfDay) {
    return NotificationTime(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
    );
  }

  const NotificationTime._();

  // 表示用
  String get display24hour =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);

  // Firestore用
  Map<String, dynamic> toMap() => {
    'hour': hour,
    'minute': minute,
  };

  static NotificationTime fromMap(Map<String, dynamic> map) {
    return NotificationTime(
      hour: (map['hour'] ?? 0) as int,
      minute: (map['minute'] ?? 0) as int,
    );
  }
}
