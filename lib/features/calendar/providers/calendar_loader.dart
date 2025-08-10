import 'package:popcal/features/calendar/domain/value_objects/calendar_schedule.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/providers/calendar_providers.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/result.dart';

part 'calendar_loader.g.dart';

@riverpod
Future<Result<CalendarScheduleResponse>> calendarScheduleResponse(
  Ref ref,
  RotationId rotationId,
) async {
  final useCase = ref.watch(getCalendarScheduleUseCaseProvider);
  final domainResult = await useCase.execute(rotationId);

  return domainResult.when(
    success: (calendarData) {
      final calendarResponseDto = CalendarScheduleResponse(
        rotationResponse: RotationResponse.fromEntity(calendarData.rotation),
        scheduleMap: _convertDayInfoMapToDto(calendarData.scheduleMap),
      );
      return Results.success(calendarResponseDto);
    },
    failure: (error) => Results.failure(error),
  );
}

Map<DateKey, ScheduleDayResponse> _convertDayInfoMapToDto(
  Map<DateKey, ScheduleDay> domainMap,
) {
  return domainMap.map(
    (key, scheduleDay) => MapEntry(
      key,
      ScheduleDayResponse(
        date: scheduleDay.date,
        memberName: scheduleDay.memberName,
        isRotationDay: scheduleDay.isRotationDay,
        memberColor: scheduleDay.memberColor,
        displayText: scheduleDay.displayText,
      ),
    ),
  );
}
