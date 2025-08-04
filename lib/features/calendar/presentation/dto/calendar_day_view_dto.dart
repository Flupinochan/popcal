import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_day.dart';

part 'calendar_day_view_dto.freezed.dart';

@freezed
sealed class CalendarDayViewDto with _$CalendarDayViewDto {
  const factory CalendarDayViewDto({
    required DateTime date,
    required String? memberName,
    required bool isRotationDay,
    required String displayText,
    required int memberColorIndex,
  }) = _CalendarDayViewDto;

  factory CalendarDayViewDto.fromEntity(
    CalendarDay entity,
    int memberColorIndex,
  ) {
    return CalendarDayViewDto(
      date: entity.date,
      memberName: entity.memberName,
      isRotationDay: entity.isRotationDay,
      displayText: entity.displayText,
      memberColorIndex: memberColorIndex,
    );
  }
}
