import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_schedule.dart';
import 'package:popcal/features/calendar/use_cases/build_calendar_schedule_use_case.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/shared/utils/time_utils.dart';

class GetCalendarScheduleUseCase {
  // UIで表示する期間かつUseCaseで計算に必要な値
  // ※過去1年and未来1年
  static const int pastDays = 365;
  static const int futureDays = 365;

  final AuthRepository _authRepository;
  final RotationRepository _rotationRepository;
  final BuildCalendarScheduleUseCase _buildCalendarScheduleUseCase;
  final TimeUtils _timeUtils;

  GetCalendarScheduleUseCase(
    this._authRepository,
    this._rotationRepository,
    this._buildCalendarScheduleUseCase,
    this._timeUtils,
  );

  // CalendarScreen表示に必要な3つの情報を取得して返却
  // UseCaseは複数のビジネスロジックを実行するため、Entityを扱う
  Future<Result<CalendarSchedule>> execute(RotationId rotationId) async {
    // 1. ユーザ情報を取得 ※.futureでstreamから1度だけ取得が可能
    final authResult = await _authRepository.getUser();
    if (authResult.isFailure) {
      return Results.failure(authResult.failureOrNull!);
    }
    final appUser = authResult.valueOrNull;
    if (appUser == null) {
      return Results.failure(AuthFailure('未認証です'));
    }

    // 2. ローテーション情報取得
    final rotationResult = await _rotationRepository.getRotation(
      appUser.userId,
      rotationId,
    );
    if (rotationResult.isFailure) {
      return Results.failure(rotationResult.failureOrNull!);
    }
    final rotation = rotationResult.valueOrNull;
    if (rotation == null) {
      return Results.failure(ValidationFailure('ローテーション情報が見つかりません'));
    }

    // 3. カレンダー表示用通知情報を取得
    final now = _timeUtils.now();
    final toDate = now.add(const Duration(days: futureDays));

    final notificationResult = _buildCalendarScheduleUseCase
        .buildCalendarSchedule(
          rotation: rotation,
          toDate: NotificationDateTime(toDate),
        );
    if (notificationResult.isFailure) {
      return Results.failure(notificationResult.failureOrNull!);
    }

    final calendarData = CalendarSchedule(
      rotation: rotation,
      scheduleMap: notificationResult.valueOrNull!,
    );

    return Results.success(calendarData);
  }
}
