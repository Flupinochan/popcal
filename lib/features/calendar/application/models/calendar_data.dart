import 'package:popcal/features/auth/domain/entities/app_user.dart';
import 'package:popcal/features/calendar/application/models/calendar_day.dart';
import 'package:popcal/features/notifications/utils/time_utils.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

// カレンダー表示用データおよびロジック
class CalendarData {
  final AppUser appUser;
  final RotationGroup rotationGroup;
  final Map<String, CalendarDay> calendarDays;

  const CalendarData({
    required this.appUser,
    required this.rotationGroup,
    required this.calendarDays,
  });

  /// 指定日の通知情報を取得
  /// 通知日でない場合はnullを返却
  CalendarDay? getNotificationForDate(DateTime date) {
    final key = TimeUtils.createDateKey(date);
    return calendarDays[key];
  }

  /// 指定日がローテーション日かどうか
  bool isRotationDay(DateTime date) {
    final calendarDay = getNotificationForDate(date);
    return calendarDay?.isRotationDay ?? false;
  }

  // 日付から表示用データを返却
  CalendarDay getCalendarDayForDate(DateTime date) {
    final key = TimeUtils.createDateKey(date);
    return calendarDays[key] ??
        CalendarDay(date: date, memberName: null, isRotationDay: false);
  }
}

// 判定: これらはビジネスロジックではなく、単純なデータアクセスヘルパーです。
// そのためapplication layer
// 複数entityにまたがる複雑な処理ではない
// MapからCalendarDayを取得しているだけ
