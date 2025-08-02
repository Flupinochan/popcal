import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/calendar/domain/entities/calendar_data.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_data_dto.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';
import 'package:popcal/features/notifications/domain/services/schedule_calculation_service.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';

class GetCalendarDataUseCase {
  // UIで表示する期間かつUseCaseで計算に必要な値
  // ※過去1年and未来1年
  static const int pastDays = 365;
  static const int futureDays = 365;

  final AuthRepository _authRepository;
  final RotationRepository _rotationRepository;
  final NotificationRepository _notificationRepository;
  final ScheduleCalculationService _scheduleCalculationService;

  GetCalendarDataUseCase(
    this._authRepository,
    this._rotationRepository,
    this._notificationRepository,
    this._scheduleCalculationService,
  );

  // CalendarScreen表示に必要な3つの情報を取得して返却
  Future<Result<CalendarDataDto>> execute(String rotationGroupId) async {
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
    final startDate = now.subtract(const Duration(days: pastDays));
    final endDate = now.add(const Duration(days: futureDays));

    final notificationResult = _scheduleCalculationService
        .buildCalendarSchedule(
          rotationGroup: rotationGroup,
          fromDate: startDate,
          toDate: endDate,
        );
    if (notificationResult.isFailure) {
      return Results.failure(notificationResult.failureOrNull!);
    }

    // 4. Entityを作成
    final calendarData = CalendarData(
      appUser: appUser,
      rotationGroup: rotationGroup,
      calendarDays: notificationResult.valueOrNull!,
    );

    // 5. 各日付表示用データを作成
    // {各日付: 各日付表示用データ} のMap
    final dayInfoMap = <String, CalendarDayDto>{};
    for (
      var date = startDate;
      date.isBefore(endDate.add(const Duration(days: 1)));
      date = date.add(const Duration(days: 1))
    ) {
      // Entityのビジネスロジックを実行
      final memberName = calendarData.getMemberNameForDate(date);
      final isRotationDay = calendarData.isRotationDay(date);

      final dayInfo = CalendarDayDto(
        date: date,
        memberName: memberName,
        isRotationDay: isRotationDay,
        displayText: isRotationDay ? "担当日" : "対象外",
      );

      final key = '${date.year}-${date.month}-${date.day}';
      dayInfoMap[key] = dayInfo;
    }

    // 6. DTOに変換して返却
    return Results.success(
      CalendarDataDto.fromEntity(calendarData, dayInfoMap),
    );
  }
}
