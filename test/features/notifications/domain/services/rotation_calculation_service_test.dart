import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service_impl.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_datetime.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
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

  group('planUpcomingNotifications', () {
    final futureDays = 30;
    final from = DateTime(2025, 8, 10, 9, 5);
    final to = from.add(Duration(days: futureDays));
    // ローテーション曜日は、月曜日と金曜日
    // 通知時刻は、10:00
    // 計算開始時刻は、2025/8/10 09:05 から+30日
    // RotationIndexは0で、user1からローテーション
    final rotation = Rotation(
      userId: UserId('user1'),
      rotationId: RotationId('rotation-test'),
      rotationName: RotationName('rotation-test'),
      rotationMemberNames: [
        RotationMemberName('user1'),
        RotationMemberName('user2'),
      ],
      rotationDays: [Weekday.monday, Weekday.friday],
      notificationTime: NotificationTime(TimeOfDay(hour: 10, minute: 0)),
      currentRotationIndex: RotationIndex(0),
      createdAt: RotationCreatedAt(DateTime(2025, 8, 10, 9, 0)),
      updatedAt: RotationUpdatedAt(DateTime(2025, 8, 10, 9, 0)),
    );

    late RotationCalculationServiceImpl service;
    late MockTimeUtils mockTimeUtils;

    setUp(() {
      mockTimeUtils = MockTimeUtils();
      service = RotationCalculationServiceImpl(mockTimeUtils);
      // スタブ設定 ※現在時刻(実行タイミングからcreatedAtやupdatedAtより少し後になる)
      when(() => mockTimeUtils.now()).thenReturn(from);
    });

    test('通常仕様', () {
      // テスト
      final result = service.planUpcomingNotifications(
        rotation: rotation,
        futureDays: futureDays,
      );
      expect(result.isSuccess, isTrue);
      final notificationSchedule = result.valueOrNull!;
      final notificationEntry = notificationSchedule.notificationEntry;
      final newCurrentRotationIndex =
          notificationSchedule.newCurrentRotationIndex;
      // RotationIndexが通知設定分+されている
      final expectedIndex =
          rotation.currentRotationIndex.value + notificationEntry.length;
      expect(newCurrentRotationIndex.value, expectedIndex);
      // 月曜日と金曜日の通知時刻が30日間分設定されている
      int expectedNotificationEntryCount = 0;
      for (
        var date = from;
        date.isBefore(to);
        date = date.add(const Duration(days: 1))
      ) {
        if (rotation.rotationDays.contains(Weekday.fromDateTime(date))) {
          expectedNotificationEntryCount++;
        }
      }
      expect(notificationEntry.length, expectedNotificationEntryCount);
      for (final entry in notificationEntry) {
        expect(entry.notificationDate.value.hour, 10);
        expect(entry.notificationDate.value.minute, 0);
      }
      // 最初のローテーション日は、user1
      expect(notificationEntry[0].memberName.value, 'user1');
      // 2日目のローテーション日は、user2
      expect(notificationEntry[1].memberName.value, 'user2');
      // 3日目のローテーション日は、user1
      expect(notificationEntry[2].memberName.value, 'user1');
      // 4日目のローテーション日は、user2
      expect(notificationEntry[3].memberName.value, 'user2');
      // メンバー名がローテーション順に割り当てられている
      for (var i = 0; i < notificationEntry.length; i++) {
        final expectedMemberIndex =
            (rotation.currentRotationIndex.value + i) %
            rotation.rotationMemberNames.length;
        final expectedMemberName =
            rotation.rotationMemberNames[expectedMemberIndex].value;
        expect(notificationEntry[i].memberName.value, expectedMemberName);
        // 通知時刻が10:00になっている
        final dt = notificationEntry[i].notificationDate.value;
        expect(dt.hour, 10);
        expect(dt.minute, 0);
      }
    });
  });
}
