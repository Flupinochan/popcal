import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_created_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_updated_at.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';

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
    required this.skipEvents,
    this.rotationId,
  });

  // Firestoreに保存した後に付与されるためオプショナル
  final RotationId? rotationId;
  final UserId userId;
  final RotationName rotationName;
  final RotationMemberNames rotationMemberNames;
  final RotationDays rotationDays;
  final NotificationTime notificationTime;
  // ローテーションした回数
  final RotationIndex currentRotationIndex;
  final RotationCreatedAt createdAt;
  final RotationUpdatedAt updatedAt;
  final SkipEvents skipEvents;

  /// UI表示用日付
  String get displayDays => rotationDays.toString();

  /// UI表示用メンバー一覧
  String get displayMembers {
    return rotationMemberNames.map((member) => member.value).join(', ');
  }

  /// UI表示用通知時刻24時間表記
  String get displayNotificationTime {
    return notificationTime.display24hour;
  }

  /// 休日スキップを取り消し可能かどうか
  bool canDisableHoliday({required DayType dayType}) {
    return dayType == DayType.holiday;
  }

  /// 休日スキップが可能かどうか
  bool canEnableHoliday({required DayType dayType}) {
    return dayType == DayType.rotationDay;
  }

  /// 交代無しスキップ可能かどうか
  bool canSkipNext({required DateKey dateKey, required DayType dayType}) {
    if (dayType == DayType.holiday || dayType == DayType.notRotationDay) {
      return false;
    }
    final skipEvent = skipEvents.getByDateKey(dateKey);
    // 1巡するskipは不可
    return skipEvent == null ||
        (rotationMemberNames.length - 1) > skipEvent.skipCount.skipCount;
  }

  /// 交代無しスキップ取り消し可能かどうか
  bool canSkipPrevious({required DateKey dateKey, required DayType dayType}) {
    if (dayType == DayType.holiday || dayType == DayType.notRotationDay) {
      return false;
    }
    final skipEvent = skipEvents.getByDateKey(dateKey);
    // 1度もskipしていない場合は不可
    return skipEvent != null && skipEvent.skipCount.skipCount > 0;
  }

  Rotation copyWith({
    RotationId? rotationId,
    UserId? userId,
    RotationName? rotationName,
    RotationMemberNames? rotationMemberNames,
    RotationDays? rotationDays,
    NotificationTime? notificationTime,
    RotationIndex? currentRotationIndex,
    RotationCreatedAt? createdAt,
    RotationUpdatedAt? updatedAt,
    SkipEvents? skipEvents,
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

  /// ローテーション回数からローテーションメンバーの配列Indexを取得
  int getRotationMemberIndex(RotationIndex rotationIndex) {
    final memberCount = getRotationMembersCount();
    if (memberCount == 0) {
      return 0;
    }
    return rotationIndex.value % memberCount;
  }

  int getRotationMembersCount() {
    return rotationMemberNames.length;
  }

  /// 有効なローテーション日かどうか
  bool isValidRotationDay({required DayType dayType}) {
    return dayType == DayType.rotationDay || dayType == DayType.skipToNext;
  }
}
