import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/presentation/dto/user_view_model_dto.dart';
import 'package:popcal/features/calendar/domain/entities/calendar_data.dart';
import 'package:popcal/features/calendar/domain/entities/calendar_day.dart';
import 'package:popcal/features/notifications/utils/time_utils.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

part 'calendar_data_dto.freezed.dart';

@freezed
sealed class CalendarDataDto with _$CalendarDataDto {
  const CalendarDataDto._();

  const factory CalendarDataDto({
    required UserViewModelDto userViewModelDto,
    required RotationGroup rotationGroup,
    required Map<String, CalendarDay> calendarDays,
  }) = _CalendarDataDto;

  // Entity => DTO
  factory CalendarDataDto.fromEntity(
    CalendarData entity,
    Map<String, CalendarDayDto> dayInfoMap,
  ) {
    return CalendarDataDto(
      userViewModelDto: UserViewModelDto.fromEntity(entity.appUser),
      rotationGroup: entity.rotationGroup,
      calendarDays: entity.calendarDays,
    );
  }

  // DTO => Entity
  Result<CalendarData> toEntity() {
    final result = userViewModelDto.toEntity();
    return result.when(
      success:
          (calendarData) => Results.success(
            CalendarData(
              appUser: result.valueOrNull!,
              rotationGroup: rotationGroup,
              calendarDays: calendarDays,
            ),
          ),
      failure: (error) => Results.failure(CalendarFailure(error.message)),
    );
  }

  CalendarDay? getDayInfo(DateTime date) {
    final key = TimeUtils.createDateKey(date);
    return calendarDays[key];
  }
}

// 各日付表示用データ
@freezed
sealed class CalendarDayDto with _$CalendarDayDto {
  const factory CalendarDayDto({
    required DateTime date,
    required String? memberName,
    required bool isRotationDay,
    required String displayText,
  }) = _CalendarDayDto;
}
