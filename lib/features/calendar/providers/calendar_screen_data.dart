import 'package:popcal/features/auth/providers/auth_provider.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_data.dart';
import 'package:popcal/features/calendar/use_cases/get_calendar_data_use_case.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_response.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';

part 'calendar_screen_data.g.dart';

// CalendarScreen表示に必要な3つの情報を取得して返却
// 画面表示時に取得する3つの非同期データを1つの.when()にまとめる
// ※リアルタイムで画面更新が必要ないため全てを初期取得1回にする
@riverpod
GetCalendarDataUseCase getCalendarDataUseCase(Ref ref) {
  return GetCalendarDataUseCase(
    ref.watch(authRepositoryProvider),
    ref.watch(rotationRepositoryProvider),
    ref.watch(calendarScheduleUseCaseProvider),
  );
}

@riverpod
Future<Result<CalendarDataResponse>> calendarScreenData(
  Ref ref,
  String rotationId,
) async {
  final useCase = ref.watch(getCalendarDataUseCaseProvider);
  final domainResult = await useCase.execute(rotationId);

  return domainResult.when(
    success: (calendarData) {
      final calendarResponseDto = CalendarDataResponse(
        rotationResponse: RotationResponse.fromEntity(calendarData.rotation),
        dayInfoMap: _convertDayInfoMapToDto(calendarData.dayInfoMap),
      );
      return Results.success(calendarResponseDto);
    },
    failure: (error) => Results.failure(error),
  );
}

Map<DateKey, CalendarDayResponse> _convertDayInfoMapToDto(
  Map<DateKey, CalendarDay> domainMap,
) {
  return domainMap.map(
    (key, domainDay) => MapEntry(
      key,
      CalendarDayResponse(
        date: domainDay.date,
        memberName: domainDay.memberName,
        isRotationDay: domainDay.isRotationDay,
        memberColorIndex: domainDay.memberColorIndex,
      ),
    ),
  );
}
