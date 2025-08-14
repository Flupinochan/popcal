import 'package:collection/collection.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';

// ローテーション設定
class Rotation {
  const Rotation({
    required this.userId,
    required this.rotationName,
    required this.rotationMemberNames,
    required this.rotationDays,
    required this.notificationTime,
    required this.currentRotationIndex,
    required this.createdAt,
    required this.updatedAt,
    this.rotationId,
    this.skipEvents = const [],
  });

  // Firestoreに保存した後に付与されるためオプショナル
  final RotationId? rotationId;
  final UserId userId;
  final RotationName rotationName;
  final List<RotationMemberName> rotationMemberNames;
  final List<Weekday> rotationDays;
  final NotificationTime notificationTime;
  // ローテーションした回数
  final RotationIndex currentRotationIndex;
  final RotationCreatedAt createdAt;
  final RotationUpdatedAt updatedAt;
  final List<SkipEvent> skipEvents;

  String get displayDays {
    return rotationDays.map((day) => day.displayName).join(', ');
  }

  String get displayMembers {
    return rotationMemberNames.map((member) => member.value).join(', ');
  }

  String get displayNotificationTime {
    return notificationTime.display24hour;
  }

  bool canSkipNext({required DateKey dateKey}) {
    final skipEvent = skipEvents.firstWhereOrNull(
      (skipEvent) => skipEvent.dateKey == dateKey,
    );

    // ローテーション日でない or 休日 はスキップ不可
    if (skipEvent != null &&
        (skipEvent.dayType == DayType.holiday ||
            skipEvent.dayType == DayType.notRotationDay)) {
      return false;
    }

    if (skipEvent == null) {
      return true;
    }

    // 1巡以上はskip不可
    return (rotationMemberNames.length - 1) > skipEvent.skipCount.skipCount;
  }

  bool canSkipPrevious({required DateKey dateKey}) {
    final skipEvent = skipEvents.firstWhereOrNull(
      (skipEvent) => skipEvent.dateKey == dateKey,
    );

    // ローテーション日でない or 休日 はスキップ不可
    if (skipEvent != null &&
        (skipEvent.dayType == DayType.holiday ||
            skipEvent.dayType == DayType.notRotationDay)) {
      return false;
    }

    if (skipEvent == null) {
      return false;
    }

    return skipEvent.skipCount.skipCount > 0;
  }

  Rotation copyWith({
    RotationId? rotationId,
    UserId? userId,
    RotationName? rotationName,
    List<RotationMemberName>? rotationMemberNames,
    List<Weekday>? rotationDays,
    NotificationTime? notificationTime,
    RotationIndex? currentRotationIndex,
    RotationCreatedAt? createdAt,
    RotationUpdatedAt? updatedAt,
    List<SkipEvent>? skipEvents,
  }) {
    return Rotation(
      rotationId: rotationId ?? this.rotationId,
      userId: userId ?? this.userId,
      rotationName: rotationName ?? this.rotationName,
      rotationMemberNames: rotationMemberNames ?? this.rotationMemberNames,
      rotationDays: rotationDays ?? this.rotationDays,
      notificationTime: notificationTime ?? this.notificationTime,
      currentRotationIndex: currentRotationIndex ?? this.currentRotationIndex,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      skipEvents: skipEvents ?? this.skipEvents,
    );
  }

  int getRotationMemberIndex(RotationIndex rotationIndex) {
    final memberCount = getRotationMembersCount();
    if (memberCount == 0) {
      return 0;
    }
    return rotationIndex.value % memberCount;
  }

  RotationMemberName getRotationMemberName(RotationIndex rotationIndex) {
    if (rotationMemberNames.isEmpty) {
      return RotationMemberName.notApplicable;
    }

    final index = getRotationMemberIndex(rotationIndex);
    if (index >= 0 && index < rotationMemberNames.length) {
      return rotationMemberNames[index];
    }

    return RotationMemberName.notApplicable;
  }

  int getRotationMembersCount() {
    return rotationMemberNames.length;
  }
}
