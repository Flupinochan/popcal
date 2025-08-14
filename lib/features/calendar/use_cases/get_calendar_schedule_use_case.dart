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

/// CalendarScreen表示に必要な情報をまとめて取得して返却
class GetCalendarScheduleUseCase {
  GetCalendarScheduleUseCase(
    this._authRepository,
    this._rotationRepository,
    this._rotationCalculationService,
    this._timeUtils,
  );
  // UIで表示する期間かつUseCaseで計算に必要な値
  // 過去1年and未来1年をカレンダー表示
  // UI側でも利用する値のため環境変数にすべき
  static const int pastDays = 365;
  static const int futureDays = 365;

  final AuthRepository _authRepository;
  final RotationRepository _rotationRepository;
  final RotationCalculationService _rotationCalculationService;
  final TimeUtils _timeUtils;

  Future<Result<CalendarSchedule>> execute(RotationId rotationId) async {
    // 1. ユーザ情報を取得
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
    // 作成時刻から(過去通知分も)表示するため、indexは0で初期化
    final initRotation = rotation.copyWith(
      currentRotationIndex: const RotationIndex(0),
    );
    final fromDateTime = initRotation.createdAt.value;
    final now = _timeUtils.now();
    final toDateTime = now.add(const Duration(days: futureDays));

    final scheduleMapResult = _rotationCalculationService
        .calculationScheduleMap(
          rotation: initRotation,
          fromDateTime: fromDateTime,
          toDateTime: toDateTime,
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
