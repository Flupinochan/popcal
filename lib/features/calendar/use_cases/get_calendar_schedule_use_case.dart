import 'package:popcal/core/utils/failures/auth_failure.dart';
import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/calendar/domain/value_objects/calendar_schedule.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_index.dart';
import 'package:popcal/shared/utils/time_utils.dart';

class GetCalendarScheduleUseCase {
  GetCalendarScheduleUseCase(
    this._authRepository,
    this._rotationRepository,
    this._rotationCalculationService,
    this._timeUtils,
  );
  // UIで表示する期間かつUseCaseで計算に必要な値
  // ※過去1年and未来1年
  static const int pastDays = 365;
  static const int futureDays = 365;

  final AuthRepository _authRepository;
  final RotationRepository _rotationRepository;
  final RotationCalculationService _rotationCalculationService;
  final TimeUtils _timeUtils;

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
      return Results.failure(const AuthFailure('未認証です'));
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
      return Results.failure(const ValidationFailure('ローテーション情報が見つかりません'));
    }

    // 3. カレンダー表示用通知情報を取得
    final now = _timeUtils.now();
    final toDateTime = now.add(const Duration(days: futureDays));
    // 作成時刻から計算するため、indexは0で初期化
    final initRotation = rotation.copyWith(
      currentRotationIndex: const RotationIndex(0),
    );

    final rotationCalculationDataResult = _rotationCalculationService
        .calculateRotationSchedule(
          rotation: initRotation,
          fromDateTime: initRotation.updatedAt.value,
          toDateTime: toDateTime,
        );
    if (rotationCalculationDataResult.isFailure) {
      return Results.failure(
        NotificationFailure(rotationCalculationDataResult.displayText),
      );
    }
    final rotationCalculationData = rotationCalculationDataResult.valueOrNull!;

    // カレンダー画面表示用データに変換
    final scheduleMapResult = _rotationCalculationService.getScheduleMap(
      initRotation,
      rotationCalculationData,
    );
    if (scheduleMapResult.isFailure) {
      return Results.failure(
        NotificationFailure(scheduleMapResult.displayText),
      );
    }
    final scheduleMap = scheduleMapResult.valueOrNull!;

    final calendarData = CalendarSchedule(
      rotation: initRotation,
      scheduleMap: scheduleMap,
    );

    return Results.success(calendarData);
  }
}
