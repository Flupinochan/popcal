// ignore_for_file: prefer-first, prefer-moving-to-variable

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service_impl.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';
import 'package:popcal/shared/utils/time_utils.dart';

void main() {
  group('getNotificationEntry', () {
    final RotationCalculationService rotationCalculationService =
        RotationCalculationServiceImpl(_MockTimeUtilsImpl());

    test('通常ローテーション', () {
      // Mockデータ
      final createdAt = DateTime(2025, 8, 7, 9);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: const UserId('test-user'),
        rotationId: RotationId('test-rotation-id'),
        rotationName: const RotationName('test-rotation'),
        rotationMemberNames: const RotationMemberNames([
          'user1',
          'user2',
          'user3',
        ]),
        rotationDays: const RotationDays([
          Weekday.monday,
          Weekday.wednesday,
          Weekday.friday,
        ]),
        notificationTime: NotificationTime(
          const TimeOfDay(hour: 10, minute: 0),
        ),
        currentRotationIndex: const RotationIndex(0),
        createdAt: RotationCreatedAt(createdAt),
        updatedAt: RotationUpdatedAt(createdAt),
        skipEvents: [],
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isSuccess, isTrue);

      final newCurrentRotationIndex =
          notificationScheduleResult.valueOrNull!.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.valueOrNull!.notificationEntries;

      // indexが通知設定分+されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      expect(
        notificationEntries[1].memberName,
        rotation.rotationMemberNames.memberAt(1),
      );
      expect(
        notificationEntries[2].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );
      expect(
        notificationEntries[3].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      expect(
        notificationEntries[4].memberName,
        rotation.rotationMemberNames.memberAt(1),
      );
      expect(
        notificationEntries[5].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );

      // 意図した通知設定日時であること
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 8, 10)),
      );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 11, 10)),
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 13, 10)),
      );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 15, 10)),
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 18, 10)),
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 20, 10)),
      );
    });

    test('作成日がローテーション曜日に含まれていて、まだ通知時刻を過ぎていない場合', () {
      // Mockデータ
      // 作成日が8/8 9:00であり、通知曜日に含まれる
      final createdAt = DateTime(2025, 8, 8, 9);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: const UserId('test-user'),
        rotationId: RotationId('test-rotation-id'),
        rotationName: const RotationName('test-rotation'),
        rotationMemberNames: const RotationMemberNames([
          'user1',
          'user2',
          'user3',
        ]),
        rotationDays: const RotationDays([
          Weekday.monday,
          Weekday.wednesday,
          Weekday.friday,
        ]),
        // 通知時刻は10:00
        notificationTime: NotificationTime(
          const TimeOfDay(hour: 10, minute: 0),
        ),
        currentRotationIndex: const RotationIndex(0),
        createdAt: RotationCreatedAt(createdAt),
        updatedAt: RotationUpdatedAt(createdAt),
        skipEvents: [],
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isSuccess, isTrue);

      final newCurrentRotationIndex =
          notificationScheduleResult.valueOrNull!.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.valueOrNull!.notificationEntries;

      // indexが通知設定分+されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      expect(
        notificationEntries[1].memberName,
        rotation.rotationMemberNames.memberAt(1),
      );
      expect(
        notificationEntries[2].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );
      expect(
        notificationEntries[3].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      expect(
        notificationEntries[4].memberName,
        rotation.rotationMemberNames.memberAt(1),
      );
      expect(
        notificationEntries[5].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );

      // 意図した通知設定日時であること
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 8, 10)),
      );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 11, 10)),
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 13, 10)),
      );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 15, 10)),
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 18, 10)),
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 20, 10)),
      );
    });

    test('作成日がローテーション曜日に含まれていて、すでに通知時刻を過ぎている場合', () {
      // Mockデータ
      // 作成日が8/8 11:00であり、通知曜日に含まれる
      final createdAt = DateTime(2025, 8, 8, 11);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: const UserId('test-user'),
        rotationId: RotationId('test-rotation-id'),
        rotationName: const RotationName('test-rotation'),
        rotationMemberNames: const RotationMemberNames([
          'user1',
          'user2',
          'user3',
        ]),
        rotationDays: const RotationDays([
          Weekday.monday,
          Weekday.wednesday,
          Weekday.friday,
        ]),
        // 通知時刻は10:00のため、作成時刻11:00をすぎている
        notificationTime: NotificationTime(
          const TimeOfDay(hour: 10, minute: 0),
        ),
        currentRotationIndex: const RotationIndex(0),
        createdAt: RotationCreatedAt(createdAt),
        updatedAt: RotationUpdatedAt(createdAt),
        skipEvents: [],
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isSuccess, isTrue);

      final newCurrentRotationIndex =
          notificationScheduleResult.valueOrNull!.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.valueOrNull!.notificationEntries;

      // indexが通知設定分+されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      expect(
        notificationEntries[1].memberName,
        rotation.rotationMemberNames.memberAt(1),
      );
      expect(
        notificationEntries[2].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );
      expect(
        notificationEntries[3].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      expect(
        notificationEntries[4].memberName,
        rotation.rotationMemberNames.memberAt(1),
      );
      expect(
        notificationEntries[5].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );

      // 意図した通知設定日時であること
      // 初回は8/8ではなく8/11
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 11, 10)),
      );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 13, 10)),
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 15, 10)),
      );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 18, 10)),
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 20, 10)),
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 22, 10)),
      );
    });

    test('休日スキップ', () {
      // Mockデータ
      final createdAt = DateTime(2025, 8, 7, 9);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: const UserId('test-user'),
        rotationId: RotationId('test-rotation-id'),
        rotationName: const RotationName('test-rotation'),
        rotationMemberNames: const RotationMemberNames([
          'user1',
          'user2',
          'user3',
        ]),
        rotationDays: const RotationDays([
          Weekday.monday,
          Weekday.wednesday,
          Weekday.friday,
        ]),
        notificationTime: NotificationTime(
          const TimeOfDay(hour: 10, minute: 0),
        ),
        currentRotationIndex: const RotationIndex(0),
        createdAt: RotationCreatedAt(createdAt),
        updatedAt: RotationUpdatedAt(createdAt),
        // 2回目のローテーション日を休日とする
        skipEvents: [
          SkipEvent(
            dateKey: DateKey(DateTime(2025, 8, 11, 10)),
            dayType: DayType.holiday,
            skipCount: const SkipCount(skipCount: 1),
          ),
        ],
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isSuccess, isTrue);

      final newCurrentRotationIndex =
          notificationScheduleResult.valueOrNull!.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.valueOrNull!.notificationEntries;

      // indexが通知設定分+されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      expect(
        notificationEntries[1].memberName,
        rotation.rotationMemberNames.memberAt(1),
      );
      expect(
        notificationEntries[2].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );
      expect(
        notificationEntries[3].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      expect(
        notificationEntries[4].memberName,
        rotation.rotationMemberNames.memberAt(1),
      );
      expect(
        notificationEntries[5].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );

      // 意図した通知設定日時であること
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 8, 10)),
      );
      // 8/11は休日
      // expect(
      //   notificationEntries[1].notificationDateTime,
      //   NotificationDateTime(DateTime(2025, 8, 11, 10)),
      // );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 13, 10)),
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 15, 10)),
      );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 18, 10)),
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 20, 10)),
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 22, 10)),
      );
    });

    test('交代無しスキップ', () {
      // Mockデータ
      final createdAt = DateTime(2025, 8, 7, 9);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: const UserId('test-user'),
        rotationId: RotationId('test-rotation-id'),
        rotationName: const RotationName('test-rotation'),
        rotationMemberNames: const RotationMemberNames([
          'user1',
          'user2',
          'user3',
        ]),
        rotationDays: const RotationDays([
          Weekday.monday,
          Weekday.wednesday,
          Weekday.friday,
        ]),
        notificationTime: NotificationTime(
          const TimeOfDay(hour: 10, minute: 0),
        ),
        currentRotationIndex: const RotationIndex(0),
        createdAt: RotationCreatedAt(createdAt),
        updatedAt: RotationUpdatedAt(createdAt),
        // 2回目のローテーション日のuser2をスキップする
        skipEvents: [
          SkipEvent(
            dateKey: DateKey(DateTime(2025, 8, 11, 10)),
            dayType: DayType.skipToNext,
            skipCount: const SkipCount(skipCount: 1),
          ),
        ],
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isSuccess, isTrue);

      final newCurrentRotationIndex =
          notificationScheduleResult.valueOrNull!.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.valueOrNull!.notificationEntries;

      // 1回Skipしているため、indexが通知設定分に加え、+1されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length + 1);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      // 2回目のuser2はスキップ
      expect(
        notificationEntries[1].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );
      expect(
        notificationEntries[2].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      expect(
        notificationEntries[3].memberName,
        rotation.rotationMemberNames.memberAt(1),
      );
      expect(
        notificationEntries[4].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );
      expect(
        notificationEntries[5].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );

      // 意図した通知設定日時であること
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 8, 10)),
      );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 11, 10)),
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 13, 10)),
      );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 15, 10)),
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 18, 10)),
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 20, 10)),
      );
    });

    test('交代無しスキップ&休日スキップ', () {
      // Mockデータ
      final createdAt = DateTime(2025, 8, 7, 9);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: const UserId('test-user'),
        rotationId: RotationId('test-rotation-id'),
        rotationName: const RotationName('test-rotation'),
        rotationMemberNames: const RotationMemberNames([
          'user1',
          'user2',
          'user3',
        ]),
        rotationDays: const RotationDays([
          Weekday.monday,
          Weekday.wednesday,
          Weekday.friday,
        ]),
        notificationTime: NotificationTime(
          const TimeOfDay(hour: 10, minute: 0),
        ),
        currentRotationIndex: const RotationIndex(0),
        createdAt: RotationCreatedAt(createdAt),
        updatedAt: RotationUpdatedAt(createdAt),
        skipEvents: [
          // 2回交代無しスキップ
          SkipEvent(
            dateKey: DateKey(DateTime(2025, 8, 11, 10)),
            dayType: DayType.skipToNext,
            skipCount: const SkipCount(skipCount: 2),
          ),
          // 休日スキップ
          SkipEvent(
            dateKey: DateKey(DateTime(2025, 8, 15, 10)),
            dayType: DayType.holiday,
            skipCount: const SkipCount(skipCount: 1),
          ),
          // 1回交代無しスキップ
          SkipEvent(
            dateKey: DateKey(DateTime(2025, 8, 22, 10)),
            dayType: DayType.skipToNext,
            skipCount: const SkipCount(skipCount: 1),
          ),
        ],
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isSuccess, isTrue);

      final newCurrentRotationIndex =
          notificationScheduleResult.valueOrNull!.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.valueOrNull!.notificationEntries;

      // 計2 + 1回Skipしているため、indexが通知設定分に加え、+3されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length + 3);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      // 2回交代無しスキップ
      expect(
        notificationEntries[1].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      expect(
        notificationEntries[2].memberName,
        rotation.rotationMemberNames.memberAt(1),
      );
      expect(
        notificationEntries[3].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );
      expect(
        notificationEntries[4].memberName,
        rotation.rotationMemberNames.memberAt(0),
      );
      // 1回交代無しスキップ
      expect(
        notificationEntries[5].memberName,
        rotation.rotationMemberNames.memberAt(2),
      );

      // 意図した通知設定日時であること
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 8, 10)),
      );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 11, 10)),
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 13, 10)),
      );
      // 休日スキップ
      // expect(
      //   notificationEntries[3].notificationDateTime,
      //   NotificationDateTime(DateTime(2025, 8, 15, 10)),
      // );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 18, 10)),
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 20, 10)),
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime(DateTime(2025, 8, 22, 10)),
      );
    });
  });
}

class _MockTimeUtilsImpl extends Mock implements TimeUtils {
  @override
  bool isSameDateKey(DateKey? a, DateKey? b) {
    if (a == null || b == null) return false;
    return a.value.year == b.value.year &&
        a.value.month == b.value.month &&
        a.value.day == b.value.day;
  }

  @override
  bool isSameDateKeyWithNotificationDateTime(
    DateKey? a,
    NotificationDateTime? b,
  ) {
    if (a == null || b == null) return false;
    return a.value.year == b.value.year &&
        a.value.month == b.value.month &&
        a.value.day == b.value.day;
  }

  @override
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // 実行タイミングから更新日より5分後に設定
  @override
  DateTime now() {
    return DateTime(2025, 8, 7, 9, 5);
  }
}
