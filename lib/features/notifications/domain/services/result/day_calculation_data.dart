import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';

/// 共通の通知計算結果
/// 通知計算は、以下2つの処理で必要になる
/// 画面表示のみで必要なメンバー名は計算結果から導ける
/// 1. 通知設定用 ※NotificationEntryに変換
/// 2. カレンダー表示用 ※ScheduleDayに変換
class DayCalculationData {
  const DayCalculationData({
    required this.notificationDateTime,
    required this.memberIndex,
    required this.dayType,
  });

  // 通知日時
  final NotificationDateTime notificationDateTime;
  // 担当者 ※ローテーション日でない場合はnull
  final int? memberIndex;
  // タイプ
  final DayType dayType;
}
