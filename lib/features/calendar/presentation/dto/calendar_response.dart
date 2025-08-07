import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';

part 'calendar_response.freezed.dart';

@freezed
sealed class CalendarDataResponse with _$CalendarDataResponse {
  const CalendarDataResponse._();

  const factory CalendarDataResponse({
    required RotationResponse rotationResponse,
    required Map<DateKey, CalendarDayResponse> dayInfoMap,
  }) = _CalendarDataResponse;

  // 指定した日付から表示用データを返却
  CalendarDayResponse getDayInfo(DateTime date) {
    final key = DateKey.fromDateTime(date);
    return dayInfoMap[key] ??
        CalendarDayResponse(
          date: date,
          memberName: null,
          isRotationDay: false,
          memberColorIndex: null,
        );
  }
}

// 各日付表示用データ
@freezed
sealed class CalendarDayResponse with _$CalendarDayResponse {
  const CalendarDayResponse._();

  const factory CalendarDayResponse({
    required DateTime date,
    required String? memberName,
    required bool isRotationDay,
    required int? memberColorIndex,
  }) = _CalendarDayResponse;

  String get displayText => isRotationDay ? "担当日" : "対象外";
}

/// Map用KeyのValueObject
@freezed
sealed class DateKey with _$DateKey {
  const factory DateKey({
    required int year,
    required int month,
    required int day,
  }) = _DateKey;

  /// DateTimeから Key を作成
  factory DateKey.fromDateTime(DateTime date) {
    return DateKey(year: date.year, month: date.month, day: date.day);
  }
}
