import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/domain/value_objects/schedule_day.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/providers/calendar_providers.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_handlers.g.dart';

@riverpod
Future<Result<CalendarScheduleResponse>> calendarScheduleResponse(
  Ref ref,
  String rotationId,
) async {
  final rotationIdResult = RotationId.create(rotationId);
  if (rotationIdResult.isError) {
    return Result.error(rotationIdResult.error);
  }

  final useCase = ref.watch(getCalendarScheduleUseCaseProvider);
  final domainResult = await useCase.execute(rotationIdResult.value);

  if (domainResult.isError) {
    return Result.error(domainResult.error);
  }

  final calendarData = domainResult.value;

  final calendarResponseDto = CalendarScheduleResponse(
    rotationResponse: RotationResponse.fromEntity(calendarData.rotation),
    scheduleMap: _convertDayInfoMapToDto(calendarData.scheduleMap),
  );

  return Result.ok(calendarResponseDto);
}

// DTO変換
Map<DateKey, ScheduleDayResponse> _convertDayInfoMapToDto(
  Map<DateKey, ScheduleDay> domainMap,
) {
  return domainMap.map(
    (key, scheduleDay) => MapEntry(
      key,
      ScheduleDayResponse(
        date: scheduleDay.notificationDateTime.value,
        memberName: scheduleDay.memberName.value,
        scheduleDayType: scheduleDay.scheduleType,
        memberColor: scheduleDay.memberColor.color,
        displayText: scheduleDay.displayText,
        canSkipNext: scheduleDay.canSkipNext,
        canSkipPrevious: scheduleDay.canSkipPrevious,
        canDisableHoliday: scheduleDay.canDisableHoliday,
        canEnableHoliday: scheduleDay.canEnableHoliday,
        isValidRotationDay: scheduleDay.isValidRotationDay,
      ),
    ),
  );
}
