import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_data.dart';
import 'package:popcal/features/notifications/use_cases/calendar_schedule_use_case.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

class GetCalendarDataUseCase {
  // UIで表示する期間かつUseCaseで計算に必要な値
  // ※過去1年and未来1年
  static const int pastDays = 365;
  static const int futureDays = 365;

  final AuthRepository _authRepository;
  final RotationRepository _rotationRepository;
  final CalendarScheduleUseCase _calendarScheduleUseCase;

  GetCalendarDataUseCase(
    this._authRepository,
    this._rotationRepository,
    this._calendarScheduleUseCase,
  );

  // CalendarScreen表示に必要な3つの情報を取得して返却
  // UseCaseは複数のビジネスロジックを実行するため、Entityを扱う
  Future<Result<CalendarData>> execute(String rotationGroupId) async {
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
    final rotationResult = await _rotationRepository.getRotationGroup(
      appUser.uidValue,
      rotationGroupId,
    );
    if (rotationResult.isFailure) {
      return Results.failure(rotationResult.failureOrNull!);
    }
    final rotationGroup = rotationResult.valueOrNull;
    if (rotationGroup == null) {
      return Results.failure(ValidationFailure('ローテーション情報が見つかりません'));
    }

    // 3. カレンダー表示用通知情報を取得
    final now = DateTime.now().toLocal();
    final endDate = now.add(const Duration(days: futureDays));

    final notificationResult = _calendarScheduleUseCase.buildCalendarSchedule(
      rotationGroup: rotationGroup,
      toDate: endDate,
    );
    if (notificationResult.isFailure) {
      return Results.failure(notificationResult.failureOrNull!);
    }

    final calendarData = CalendarData(
      rotationGroup: rotationGroup,
      dayInfoMap: notificationResult.valueOrNull!,
    );

    return Results.success(calendarData);
  }
}
