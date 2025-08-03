import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/auth/presentation/dto/user_view_model_dto.dart';
import 'package:popcal/features/calendar/domain/entities/calendar_data.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_day_view_dto.dart';
import 'package:popcal/features/notifications/utils/time_utils.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

part 'calendar_data_dto.freezed.dart';

@freezed
sealed class CalendarDataDto with _$CalendarDataDto {
  const CalendarDataDto._();

  const factory CalendarDataDto({
    required UserViewModelDto userViewModelDto,
    required RotationGroup rotationGroup,
    required Map<String, CalendarDayViewDto> dayInfoMap,
  }) = _CalendarDataDto;

  // Entity => DTO
  factory CalendarDataDto.fromEntity(
    CalendarData entity,
    Map<String, CalendarDayViewDto> dayInfoMap,
  ) {
    return CalendarDataDto(
      userViewModelDto: UserViewModelDto.fromEntity(entity.appUser),
      rotationGroup: entity.rotationGroup,
      dayInfoMap: dayInfoMap,
    );
  }

  CalendarDayViewDto? getDayInfo(DateTime date) {
    final key = TimeUtils.createDateKey(date);
    return dayInfoMap[key];
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
