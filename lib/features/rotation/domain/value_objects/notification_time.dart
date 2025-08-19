import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

part 'notification_time.freezed.dart';

/// TimeOfDayはfreezedサポート対象外のため、intのhourとminuteを組み合わせることにする
@freezed
sealed class NotificationTime with _$NotificationTime {
  @Deprecated('.fromTimeOfDayファクトリメソッドで生成してください')
  const factory NotificationTime({
    required int hour,
    required int minute,
  }) = _NotificationTime;

  // TimeOfDayから生成
  factory NotificationTime.fromTimeOfDay(TimeOfDay timeOfDay) {
    return NotificationTime(
      hour: timeOfDay.hour,
      minute: timeOfDay.minute,
    );
  }

  const NotificationTime._();

  String get display24hour =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);

  // Firestore用
  Map<String, dynamic> toMap() => {
    'hour': hour,
    'minute': minute,
  };

  // intから作成
  static Result<NotificationTime> createFromInt({
    required int hour,
    required int minute,
  }) {
    if (hour < 0 || hour > 23) {
      Results.failure<NotificationTime>(
        const ValidationFailure('hour must be between 0 and 23'),
      );
    }

    if (minute < 0 || minute > 59) {
      Results.failure<NotificationTime>(
        const ValidationFailure('minute must be between 0 and 59'),
      );
    }

    return Results.success(
      NotificationTime(
        hour: hour,
        minute: minute,
      ),
    );
  }

  static NotificationTime fromMap(Map<String, dynamic> map) {
    return NotificationTime(
      hour: (map['hour'] ?? 0) as int,
      minute: (map['minute'] ?? 0) as int,
    );
  }
}
