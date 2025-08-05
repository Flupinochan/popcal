import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/notifications/utils/time_utils.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

part 'calendar_response.freezed.dart';

@freezed
sealed class CalendarResponse with _$CalendarResponse {
  const CalendarResponse._();

  const factory CalendarResponse({
    required UserResponse userViewModelDto,
    required RotationGroup rotationGroup,
    required Map<String, CalendarDayViewModel> dayInfoMap,
  }) = _CalendarResponse;

  /// 指定日の通知情報を取得
  /// 通知日でない場合はnullを返却
  CalendarDayViewModel? getDayInfo(DateTime date) {
    final key = TimeUtils.createDateKey(date);
    return dayInfoMap[key];
  }

  // 日付から表示用データを返却
  CalendarDayViewModel getCalendarDayForDate(DateTime date) {
    final key = TimeUtils.createDateKey(date);
    return dayInfoMap[key] ??
        CalendarDayViewModel(
          date: date,
          memberName: null,
          isRotationDay: false,
          memberColorIndex: null,
        );
  }

  /// 指定日がローテーション日かどうか
  bool isRotationDay(DateTime date) {
    final calendarDay = getNotificationForDate(date);
    return calendarDay?.isRotationDay ?? false;
  }

  /// 指定日の通知情報を取得
  /// 通知日でない場合はnullを返却
  CalendarDayViewModel? getNotificationForDate(DateTime date) {
    final key = TimeUtils.createDateKey(date);
    return dayInfoMap[key];
  }
}

// 各日付表示用データ
@freezed
sealed class CalendarDayViewModel with _$CalendarDayViewModel {
  const CalendarDayViewModel._();

  const factory CalendarDayViewModel({
    required DateTime date,
    required String? memberName,
    required bool isRotationDay,
    required int? memberColorIndex,
  }) = _CalendarDayViewModel;

  String get displayText => isRotationDay ? "担当日" : "対象外";
}
