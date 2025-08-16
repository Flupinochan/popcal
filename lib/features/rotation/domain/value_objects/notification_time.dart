import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_time.freezed.dart';
part 'notification_time.g.dart';

/// TimeOfDayはfreezedサポート対象外のため、intのhourとminuteを組み合わせることにする
@freezed
sealed class NotificationTime with _$NotificationTime {
  const factory NotificationTime({
    required int hour,
    required int minute,
  }) = _NotificationTime;

  factory NotificationTime.fromJson(Map<String, dynamic> json) =>
      _$NotificationTimeFromJson(json);

  const NotificationTime._();

  String get display24hour =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  TimeOfDay get timeOfDay => TimeOfDay(hour: hour, minute: minute);
}
