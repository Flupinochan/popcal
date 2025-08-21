import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/notifications/domain/entities/notification_setting.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';

part 'notification_schedule.freezed.dart';

@freezed
sealed class NotificationSchedule with _$NotificationSchedule {
  const factory NotificationSchedule({
    // 30日分の通知設定計算結果
    required List<NotificationSetting> notificationEntries,
    // 通知計算の後にローテーション情報を更新するために必要
    required RotationIndex newCurrentRotationIndex,
  }) = _NotificationSchedule;

  const NotificationSchedule._();
}
