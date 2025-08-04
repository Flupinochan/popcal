import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_day.freezed.dart';

/// カレンダーの各日付表示用データ
@freezed
sealed class CalendarDay with _$CalendarDay {
  const CalendarDay._();

  const factory CalendarDay({
    required DateTime date,
    required String? memberName,
    required bool isRotationDay,
  }) = _CalendarDay;

  String get displayText => isRotationDay ? "担当日" : "対象外";
}
