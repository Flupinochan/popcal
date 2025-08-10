import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service_impl.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_datetime.dart';
import 'package:popcal/shared/utils/time_utils.dart';

class MockTimeUtils extends Mock implements TimeUtils {}

void main() {
  group('findNextRotationDate', () {
    late RotationCalculationServiceImpl service;
    late MockTimeUtils mockTimeUtils;

    setUp(() {
      mockTimeUtils = MockTimeUtils();
      service = RotationCalculationServiceImpl(mockTimeUtils);
    });

    test('明日がローテーション曜日の場合は、明日の日付を返す', () {
      // ローテーション作成日 (月曜日2025/8/11)
      final currentTime = DateTime(2025, 8, 11, 10, 0);
      final rotationDateTime = RotationDateTime.createdAt(
        RotationCreatedAt(currentTime),
      );
      // ローテーション曜日は火曜日
      final rotationDays = [Weekday.tuesday];
      // 通知時刻
      final notificationTime = NotificationTime(TimeOfDay(hour: 10, minute: 0));

      // テスト
      final result = service.findNextRotationDate(
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        rotationDateTime: rotationDateTime,
      );

      // 火曜日は月曜日から+1日(2025/8/12)
      expect(result.isSuccess, isTrue);
      final nextDate = result.valueOrNull!;
      expect(nextDate.year, 2025);
      expect(nextDate.month, 8);
      expect(nextDate.day, 12);
    });

    test('ローテーション作成日の今日がローテーション曜日で、すでに通知時刻を過ぎている場合は、来週のローテーション曜日の日付を返す', () {
      // ローテーション作成日 (月曜日2025/8/11 10:00)
      final currentTime = DateTime(2025, 8, 11, 10, 0);
      final rotationDateTime = RotationDateTime.createdAt(
        RotationCreatedAt(currentTime),
      );
      // ローテーション曜日は月曜日
      final rotationDays = [Weekday.monday];
      // 通知時刻 (7:00) ※作成時刻より前の時刻
      final notificationTime = NotificationTime(TimeOfDay(hour: 7, minute: 0));

      // テスト
      final result = service.findNextRotationDate(
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        rotationDateTime: rotationDateTime,
      );

      // 来週の月曜日を返す(2025/8/18)
      expect(result.isSuccess, isTrue);
      final nextDate = result.valueOrNull!;
      expect(nextDate.year, 2025);
      expect(nextDate.month, 8);
      expect(nextDate.day, 18);
    });

    test('ローテーション作成日の今日がローテーション曜日で、まだ通知時刻を過ぎていない場合は、今日の日付を返す', () {
      // ローテーション作成日 (月曜日2025/8/11 10:00)
      final currentTime = DateTime(2025, 8, 11, 10, 0);
      final rotationDateTime = RotationDateTime.createdAt(
        RotationCreatedAt(currentTime),
      );
      // ローテーション曜日は月曜日
      final rotationDays = [Weekday.monday];
      // 通知時刻 (7:00) ※作成時刻より後の時刻
      final notificationTime = NotificationTime(TimeOfDay(hour: 12, minute: 0));

      // テスト
      final result = service.findNextRotationDate(
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        rotationDateTime: rotationDateTime,
      );

      // 来週の月曜日を返す(2025/8/18)
      expect(result.isSuccess, isTrue);
      final nextDate = result.valueOrNull!;
      expect(nextDate.year, 2025);
      expect(nextDate.month, 8);
      expect(nextDate.day, 11);
    });
  });

  group('isValidNotificationDate', () {
    late RotationCalculationServiceImpl service;
    late MockTimeUtils mockTimeUtils;

    setUp(() {
      mockTimeUtils = MockTimeUtils();
      service = RotationCalculationServiceImpl(mockTimeUtils);
    });

    test('ローテーション曜日が月曜日で、チェック日付が月曜日でない場合はFalseを返す', () {
      // チェック日付は火曜日
      final checkDate = DateKey(DateTime(2025, 8, 12));
      // ローテーション曜日は月曜日
      final rotationDays = [Weekday.monday];
      // 通知時刻
      final notificationTime = NotificationTime(TimeOfDay(hour: 10, minute: 0));
      // ローテーション作成時刻
      final rotationDateTime = RotationDateTime.createdAt(
        RotationCreatedAt(DateTime(2025, 8, 11, 10, 0)),
      );

      // テスト
      final result = service.isValidNotificationDate(
        checkDate: checkDate,
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        rotationDateTime: rotationDateTime,
      );

      expect(result, isFalse);
    });

    test('ローテーション曜日が月曜日で、チェック日付が月曜日で、すでに通知時刻を過ぎている場合はFalseを返す', () {
      // チェック日付は月曜日
      final checkDate = DateKey(DateTime(2025, 8, 11));
      // ローテーション曜日は月曜日
      final rotationDays = [Weekday.monday];
      // 通知時刻11:00
      final notificationTime = NotificationTime(TimeOfDay(hour: 9, minute: 0));
      // ローテーション作成時刻 ※今日(月曜日)
      final rotationDateTime = RotationDateTime.createdAt(
        RotationCreatedAt(DateTime(2025, 8, 11, 10, 0)),
      );

      // テスト
      // 計算式: チェック日付+通知時刻(2025/8/11 9:00) > ローテーション作成時刻(2025/8/11 10:00)
      final result = service.isValidNotificationDate(
        checkDate: checkDate,
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        rotationDateTime: rotationDateTime,
      );

      expect(result, isFalse);
    });

    test('ローテーション曜日が月曜日で、チェック日付が月曜日で、まだ通知時刻を過ぎていない場合はTrueを返す', () {
      // チェック日付は月曜日
      final checkDate = DateKey(DateTime(2025, 8, 11));
      // ローテーション曜日は月曜日
      final rotationDays = [Weekday.monday];
      // 通知時刻11:00
      final notificationTime = NotificationTime(TimeOfDay(hour: 11, minute: 0));
      // ローテーション作成時刻 ※今日(月曜日)
      final rotationDateTime = RotationDateTime.createdAt(
        RotationCreatedAt(DateTime(2025, 8, 11, 10, 0)),
      );

      // テスト
      // 計算式: チェック日付+通知時刻(2025/8/11 11:00) > ローテーション作成時刻(2025/8/11 10:00)
      final result = service.isValidNotificationDate(
        checkDate: checkDate,
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        rotationDateTime: rotationDateTime,
      );

      expect(result, isTrue);
    });
  });
}
