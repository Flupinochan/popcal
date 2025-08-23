// ignore_for_file: prefer-first, prefer-moving-to-variable

import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service_impl.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_content.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';

import '../../../../fixtures/value_objects/mock_rotation_id.dart';
import '../../../../fixtures/value_objects/mock_rotation_name.dart';
import '../../../../fixtures/value_objects/mock_user_id.dart';

void main() {
  group('CalculationService', () {
    final RotationCalculationService rotationCalculationService =
        RotationCalculationServiceImpl(Logger('RotationCalculationService'));

    test('通常ローテーション', () {
      final createdAt = DateTime(2025, 8, 7, 9);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: MockUserId.userId,
        rotationId: MockRotationId.rotationId,
        rotationName: MockRotationName.rotationName,
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
        notificationTime:
            NotificationTime.createFromInt(hour: 10, minute: 0).value,
        currentRotationIndex: RotationIndex(),
        createdAt: RotationCreatedAt.create(createdAt).value,
        updatedAt: RotationUpdatedAt.create(createdAt).value,
        skipEvents: SkipEvents.empty(),
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isError, isFalse);

      final newCurrentRotationIndex =
          notificationScheduleResult.value.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.value.notificationEntries;

      // indexが通知設定分+されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[1].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(1).value,
        ),
      );
      expect(
        notificationEntries[2].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );
      expect(
        notificationEntries[3].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[4].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(1).value,
        ),
      );
      expect(
        notificationEntries[5].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );

      // 意図した通知設定日時であること
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 8, 10)).value,
      );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 11, 10)).value,
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 13, 10)).value,
      );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 15, 10)).value,
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 18, 10)).value,
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 20, 10)).value,
      );
    });

    test('作成日がローテーション曜日に含まれていて、まだ通知時刻を過ぎていない場合', () {
      // Mockデータ
      // 作成日が8/8 9:00であり、通知曜日に含まれる
      final createdAt = DateTime(2025, 8, 8, 9);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: MockUserId.userId,
        rotationId: MockRotationId.rotationId,
        rotationName: MockRotationName.rotationName,
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
        notificationTime:
            NotificationTime.createFromInt(hour: 10, minute: 0).value,
        currentRotationIndex: RotationIndex(),
        createdAt: RotationCreatedAt.create(createdAt).value,
        updatedAt: RotationUpdatedAt.create(createdAt).value,
        skipEvents: SkipEvents.empty(),
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isError, isFalse);

      final newCurrentRotationIndex =
          notificationScheduleResult.value.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.value.notificationEntries;

      // indexが通知設定分+されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[1].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(1).value,
        ),
      );
      expect(
        notificationEntries[2].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );
      expect(
        notificationEntries[3].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[4].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(1).value,
        ),
      );
      expect(
        notificationEntries[5].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );

      // 意図した通知設定日時であること
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 8, 10)).value,
      );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 11, 10)).value,
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 13, 10)).value,
      );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 15, 10)).value,
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 18, 10)).value,
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 20, 10)).value,
      );
    });

    test('作成日がローテーション曜日に含まれていて、すでに通知時刻を過ぎている場合', () {
      // Mockデータ
      // 作成日が8/8 11:00であり、通知曜日に含まれる
      final createdAt = DateTime(2025, 8, 8, 11);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: MockUserId.userId,
        rotationId: MockRotationId.rotationId,
        rotationName: MockRotationName.rotationName,
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
        notificationTime:
            NotificationTime.createFromInt(hour: 10, minute: 0).value,
        currentRotationIndex: RotationIndex(),
        createdAt: RotationCreatedAt.create(createdAt).value,
        updatedAt: RotationUpdatedAt.create(createdAt).value,
        skipEvents: SkipEvents.empty(),
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isError, isFalse);

      final newCurrentRotationIndex =
          notificationScheduleResult.value.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.value.notificationEntries;

      // indexが通知設定分+されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[1].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(1).value,
        ),
      );
      expect(
        notificationEntries[2].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );
      expect(
        notificationEntries[3].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[4].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(1).value,
        ),
      );
      expect(
        notificationEntries[5].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );

      // 意図した通知設定日時であること
      // 初回は8/8ではなく8/11
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 11, 10)).value,
      );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 13, 10)).value,
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 15, 10)).value,
      );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 18, 10)).value,
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 20, 10)).value,
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 22, 10)).value,
      );
    });

    test('休日スキップ', () {
      // Mockデータ
      final createdAt = DateTime(2025, 8, 7, 9);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: MockUserId.userId,
        rotationId: MockRotationId.rotationId,
        rotationName: MockRotationName.rotationName,
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
        notificationTime:
            NotificationTime.createFromInt(hour: 10, minute: 0).value,
        currentRotationIndex: RotationIndex(),
        createdAt: RotationCreatedAt.create(createdAt).value,
        updatedAt: RotationUpdatedAt.create(createdAt).value,
        // 2回目のローテーション日を休日とする
        skipEvents: SkipEvents(
          [
            SkipEvent(
              dateKey: DateKey.create(DateTime(2025, 8, 11, 10)).value,
              dayType: DayType.holiday,
              skipCount: SkipCount(),
            ),
          ],
        ),
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isError, isFalse);

      final newCurrentRotationIndex =
          notificationScheduleResult.value.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.value.notificationEntries;

      // indexが通知設定分+されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[1].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(1).value,
        ),
      );
      expect(
        notificationEntries[2].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );
      expect(
        notificationEntries[3].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[4].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(1).value,
        ),
      );
      expect(
        notificationEntries[5].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );

      // 意図した通知設定日時であること
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 8, 10)).value,
      );
      // 8/11は休日
      // expect(
      //   notificationEntries[1].notificationDateTime,
      //   NotificationDateTime.create(DateTime(2025, 8, 11, 10)).value,
      // );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 13, 10)).value,
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 15, 10)).value,
      );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 18, 10)).value,
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 20, 10)).value,
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 22, 10)).value,
      );
    });

    test('交代無しスキップ', () {
      // Mockデータ
      final createdAt = DateTime(2025, 8, 7, 9);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: MockUserId.userId,
        rotationId: MockRotationId.rotationId,
        rotationName: MockRotationName.rotationName,
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
        notificationTime:
            NotificationTime.createFromInt(hour: 10, minute: 0).value,
        currentRotationIndex: RotationIndex(),
        createdAt: RotationCreatedAt.create(createdAt).value,
        updatedAt: RotationUpdatedAt.create(createdAt).value,
        // 2回目のローテーション日のuser2をスキップする
        skipEvents: SkipEvents([
          SkipEvent(
            dateKey: DateKey.create(DateTime(2025, 8, 11, 10)).value,
            dayType: DayType.skipToNext,
            skipCount: SkipCount(),
          ),
        ]),
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isError, isFalse);

      final newCurrentRotationIndex =
          notificationScheduleResult.value.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.value.notificationEntries;

      // 1回Skipしているため、indexが通知設定分に加え、+1されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length + 1);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[1].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );
      expect(
        notificationEntries[2].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[3].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(1).value,
        ),
      );
      expect(
        notificationEntries[4].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );
      expect(
        notificationEntries[5].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );

      // 意図した通知設定日時であること
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 8, 10)).value,
      );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 11, 10)).value,
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 13, 10)).value,
      );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 15, 10)).value,
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 18, 10)).value,
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 20, 10)).value,
      );
    });

    test('交代無しスキップ&休日スキップ', () {
      // Mockデータ
      final createdAt = DateTime(2025, 8, 7, 9);
      final toDateTime = createdAt.add(const Duration(days: 30));
      final rotation = Rotation(
        userId: MockUserId.userId,
        rotationId: MockRotationId.rotationId,
        rotationName: MockRotationName.rotationName,
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
        notificationTime:
            NotificationTime.createFromInt(hour: 10, minute: 0).value,
        currentRotationIndex: RotationIndex(),
        createdAt: RotationCreatedAt.create(createdAt).value,
        updatedAt: RotationUpdatedAt.create(createdAt).value,
        skipEvents: SkipEvents(
          [
            // 2回交代無しスキップ
            SkipEvent(
              dateKey: DateKey.create(DateTime(2025, 8, 11, 10)).value,
              dayType: DayType.skipToNext,
              skipCount: SkipCount(skipCount: 2),
            ),
            // 休日スキップ
            SkipEvent(
              dateKey: DateKey.create(DateTime(2025, 8, 15, 10)).value,
              dayType: DayType.holiday,
              skipCount: SkipCount(),
            ),
            // 1回交代無しスキップ
            SkipEvent(
              dateKey: DateKey.create(DateTime(2025, 8, 22, 10)).value,
              dayType: DayType.skipToNext,
              skipCount: SkipCount(),
            ),
          ],
        ),
      );

      // 実行
      final notificationScheduleResult = rotationCalculationService
          .calculationNotificationSchedule(
            rotation: rotation,
            fromDateTime: createdAt,
            toDateTime: toDateTime,
          );
      expect(notificationScheduleResult.isError, isFalse);

      final newCurrentRotationIndex =
          notificationScheduleResult.value.newCurrentRotationIndex;
      final notificationEntries =
          notificationScheduleResult.value.notificationEntries;

      // 計2 + 1回Skipしているため、indexが通知設定分に加え、+3されていること
      expect(newCurrentRotationIndex.value, notificationEntries.length + 3);

      // 順番どおりのメンバー名であること
      expect(
        notificationEntries[0].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      // 2回交代無しスキップ
      expect(
        notificationEntries[1].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      expect(
        notificationEntries[2].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(1).value,
        ),
      );
      expect(
        notificationEntries[3].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );
      expect(
        notificationEntries[4].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(0).value,
        ),
      );
      // 1回交代無しスキップ
      expect(
        notificationEntries[5].content.value,
        NotificationContent.createFromRotationMemberName(
          rotation.rotationMemberNames.memberAt(2).value,
        ),
      );

      // 意図した通知設定日時であること
      expect(
        notificationEntries[0].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 8, 10)).value,
      );
      expect(
        notificationEntries[1].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 11, 10)).value,
      );
      expect(
        notificationEntries[2].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 13, 10)).value,
      );
      // 休日スキップ
      // expect(
      //   notificationEntries[3].notificationDateTime,
      //   NotificationDateTime.create(DateTime(2025, 8, 15, 10)).value,
      // );
      expect(
        notificationEntries[3].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 18, 10)).value,
      );
      expect(
        notificationEntries[4].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 20, 10)).value,
      );
      expect(
        notificationEntries[5].notificationDateTime,
        NotificationDateTime.create(DateTime(2025, 8, 22, 10)).value,
      );
    });
  });
}
