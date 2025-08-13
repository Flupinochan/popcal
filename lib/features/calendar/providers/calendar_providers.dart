import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/calendar/use_cases/get_calendar_schedule_use_case.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_providers.g.dart';

// CalendarScreen表示に必要な3つの情報を取得して返却
// 画面表示時に取得する3つの非同期データを1つの.when()にまとめる
// ※リアルタイムで画面更新が必要ないため全てを初期取得1回にする
@riverpod
GetCalendarScheduleUseCase getCalendarScheduleUseCase(Ref ref) {
  return GetCalendarScheduleUseCase(
    ref.watch(authRepositoryProvider),
    ref.watch(rotationRepositoryProvider),
    ref.watch(rotationCalculationServiceProvider),
    ref.watch(timeUtilsProvider),
  );
}
