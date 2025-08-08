import 'package:popcal/features/calendar/domain/value_objects/calendar_schedule.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/providers/calendar_providers.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/result.dart';

part 'calendar_loader.g.dart';

@riverpod
Future<Result<CalendarScheduleResponse>> calendarScheduleResponse(
  Ref ref,
  String rotationId,
) async {
  final useCase = ref.watch(getCalendarDataUseCaseProvider);
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
    (key, domainDay) => MapEntry(
      key,
      ScheduleDayResponse(
        date: domainDay.date,
        memberName: domainDay.memberName,
        isRotationDay: domainDay.isRotationDay,
        memberColorIndex: domainDay.memberColorIndex,
      ),
    ),
  );
}
