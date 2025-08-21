import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/results.dart';
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

part 'rotation.freezed.dart';

@freezed
sealed class Rotation with _$Rotation {
  factory Rotation({
    required UserId userId,
    required RotationName rotationName,
    required RotationMemberNames rotationMemberNames,
    required RotationDays rotationDays,
    required NotificationTime notificationTime,
    required RotationIndex currentRotationIndex,
    required RotationCreatedAt createdAt,
    required RotationUpdatedAt updatedAt,
    required SkipEvents skipEvents,
    // RotationIdはfirebaseの機能によって作成されるため、作成時はoptional
    RotationId? rotationId,
  }) = _Rotation;

  const Rotation._();

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

  bool get isRotationIdExist => rotationId != null;

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
        (rotationMemberNames.length - 1) > skipEvent.skipCount.value;
  }

  /// 交代無しスキップ取り消し可能かどうか
  bool canSkipPrevious({required DateKey dateKey, required DayType dayType}) {
    if (dayType == DayType.holiday || dayType == DayType.notRotationDay) {
      return false;
    }
    final skipEvent = skipEvents.getByDateKey(dateKey);
    // 1度もskipしていない場合は不可
    return skipEvent != null && skipEvent.skipCount.value > 0;
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

  static Result<Rotation> create({
    required UserId userId,
    required RotationName rotationName,
    required RotationMemberNames rotationMemberNames,
    required RotationDays rotationDays,
    required NotificationTime notificationTime,
    required SkipEvents skipEvents,
    required DateTime currentTime,
  }) {
    final rotationCreatedAtResult = RotationCreatedAt.create(currentTime);
    if (rotationCreatedAtResult.isError) {
      return Result.error(rotationCreatedAtResult.error);
    }

    final rotationUpdatedAtResult = RotationUpdatedAt.create(currentTime);
    if (rotationUpdatedAtResult.isError) {
      return Result.error(rotationUpdatedAtResult.error);
    }

    return Result.ok(
      Rotation(
        userId: userId,
        rotationName: rotationName,
        rotationMemberNames: rotationMemberNames,
        rotationDays: rotationDays,
        notificationTime: notificationTime,
        // 作成時のIndexは0
        currentRotationIndex: RotationIndex(),
        // 時刻はUseCase層で生成
        createdAt: rotationCreatedAtResult.value,
        updatedAt: rotationUpdatedAtResult.value,
        skipEvents: skipEvents,
      ),
    );
  }

  // updateはcopyWithで実行
}
