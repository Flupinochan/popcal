import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/calendar/application/models/calendar_day.dart';

part 'calendar_day_view_model.freezed.dart';

@freezed
sealed class CalendarDayViewModel with _$CalendarDayViewModel {
  const factory CalendarDayViewModel({
    required DateTime date,
    required String? memberName,
    required bool isRotationDay,
    required String displayText,
    required int memberColorIndex,
  }) = _CalendarDayViewModel;

  factory CalendarDayViewModel.fromEntity(
    CalendarDay entity,
    int memberColorIndex,
  ) {
    return CalendarDayViewModel(
      date: entity.date,
      memberName: entity.memberName,
      isRotationDay: entity.isRotationDay,
      displayText: entity.displayText,
      memberColorIndex: memberColorIndex,
    );
  }
}
