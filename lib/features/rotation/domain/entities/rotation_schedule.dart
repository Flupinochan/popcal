import 'package:flutter/material.dart';
// import 'package:popcal/features/rotation/domain/entities/sample/day_of_week.dart';
// import 'package:popcal/features/rotation/domain/entities/sample/schedule_type.dart';

/// ローテーションのスケジュール設定を管理するエンティティ
class RotationSchedule {
  /// ローテーション開始日時
  final DateTime startDateTime;

  /// スケジュールタイプ（週次 or 月次）
  // final ScheduleType scheduleType;

  /// 週次の場合の実行曜日リスト
  /// 例: [月曜日, 金曜日] → 週2回実行
  // final List<DayOfWeek>? daysOfWeek;

  /// 月次の場合の実行日
  /// 例: 15 → 毎月15日に実行（月末の場合は自動調整）
  // final int? dayOfMonth;

  /// ミーティング開始時刻
  final TimeOfDay meetingTime;

  /// 通知タイミング（ミーティング開始の何分前に通知するか）
  /// デフォルト: 5分前
  final int notificationMinutesBefore;

  const RotationSchedule({
    required this.startDateTime,
    // required this.scheduleType,
    // this.daysOfWeek,
    // this.dayOfMonth,
    required this.meetingTime,
    this.notificationMinutesBefore = 5,
  });

  // /// 設定の妥当性をチェック
  // bool get isValid {
  //   switch (scheduleType) {
  //     case ScheduleType.weekly:
  //       return daysOfWeek != null && daysOfWeek!.isNotEmpty;
  //     case ScheduleType.monthly:
  //       return dayOfMonth != null && dayOfMonth! >= 1 && dayOfMonth! <= 31;
  //   }
  // }

  /// 通知予定時刻を計算
  DateTime calculateNotificationTime(DateTime meetingDateTime) {
    return meetingDateTime.subtract(
      Duration(minutes: notificationMinutesBefore),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startDateTime': startDateTime.toIso8601String(),
      'meetingTime': {'hour': meetingTime.hour, 'minute': meetingTime.minute},
      'notificationMinutesBefore': notificationMinutesBefore,
    };
  }
}
