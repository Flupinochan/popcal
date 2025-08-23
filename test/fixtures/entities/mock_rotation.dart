import 'package:flutter/material.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';

class MockRotation {
  static final Rotation rotation1 = Rotation(
    userId: UserId.create('test-user1').value,
    rotationId: RotationId.create('test-rotation-id1').value,
    rotationName: RotationName.create('test-rotation1').value,
    rotationMemberNames: const RotationMemberNames([
      'test-member1',
      'test-member2',
      'test-member3',
    ]),
    rotationDays: const RotationDays([
      Weekday.monday,
      Weekday.wednesday,
      Weekday.friday,
    ]),
    notificationTime: NotificationTime.fromTimeOfDay(
      const TimeOfDay(hour: 15, minute: 0),
    ),
    currentRotationIndex: RotationIndex(),
    createdAt: RotationCreatedAt.create(DateTime(2025, 8, 31, 9)).value,
    updatedAt: RotationUpdatedAt.create(DateTime(2025, 8, 31, 9)).value,
    skipEvents: SkipEvents.empty(),
  );

  static final Rotation rotation2 = Rotation(
    userId: UserId.create('test-user2').value,
    rotationId: RotationId.create('test-rotation-id2').value,
    rotationName: RotationName.create('test-rotation2').value,
    rotationMemberNames: const RotationMemberNames([
      'test-member4',
      'test-member5',
      'test-member6',
    ]),
    rotationDays: const RotationDays([
      Weekday.tuesday,
      Weekday.thursday,
    ]),
    notificationTime: NotificationTime.fromTimeOfDay(
      const TimeOfDay(hour: 22, minute: 0),
    ),
    currentRotationIndex: RotationIndex(),
    createdAt: RotationCreatedAt.create(DateTime(2025, 8, 31, 9)).value,
    updatedAt: RotationUpdatedAt.create(DateTime(2025, 8, 31, 9)).value,
    skipEvents: SkipEvents.empty(),
  );
}
