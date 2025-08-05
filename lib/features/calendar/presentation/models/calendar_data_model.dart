import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/calendar/application/models/calendar_data.dart';
import 'package:popcal/features/calendar/presentation/models/calendar_day_view_model.dart';
import 'package:popcal/features/notifications/utils/time_utils.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

part 'calendar_data_model.freezed.dart';

@freezed
sealed class CalendarDataModel with _$CalendarDataModel {
  const CalendarDataModel._();

  const factory CalendarDataModel({
    required UserResponse userViewModelDto,
    required RotationGroup rotationGroup,
    required Map<String, CalendarDayViewModel> dayInfoMap,
  }) = _CalendarDataModel;

  // Entity => DTO
  factory CalendarDataModel.fromEntity(
    CalendarData entity,
    Map<String, CalendarDayViewModel> dayInfoMap,
  ) {
    return CalendarDataModel(
      userViewModelDto: UserResponse.fromEntity(entity.appUser),
      rotationGroup: entity.rotationGroup,
      dayInfoMap: dayInfoMap,
    );
  }

  CalendarDayViewModel? getDayInfo(DateTime date) {
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
