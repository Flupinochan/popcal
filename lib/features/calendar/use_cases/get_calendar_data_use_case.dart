import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_response.dart';
import 'package:popcal/features/notifications/use_cases/calendar_schedule_use_case.dart';
import 'package:popcal/features/notifications/utils/time_utils.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_group_response.dart';

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
  Future<Result<CalendarResponse>> execute(String rotationGroupId) async {
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
    final rotationGroupDto = RotationGroupResponse.fromEntity(rotationGroup);

    // 3. カレンダー表示用通知情報を取得
    final now = DateTime.now().toLocal();
    final startDate = now.subtract(const Duration(days: pastDays));
    final endDate = now.add(const Duration(days: futureDays));

    final notificationResult = _calendarScheduleUseCase.buildCalendarSchedule(
      rotationGroupDto: rotationGroupDto,
      toDate: endDate,
    );
    if (notificationResult.isFailure) {
      return Results.failure(notificationResult.failureOrNull!);
    }

    // 4. Entityを作成
    final calendarData = CalendarResponse(
      userViewModelDto: UserResponse.fromEntity(appUser),
      rotationGroup: rotationGroup,
      dayInfoMap: notificationResult.valueOrNull!,
    );

    // 5. 各日付表示用データを作成
    // {各日付: 各日付表示用データ} のMap
    final dayInfoMap = <String, CalendarDayViewModel>{};
    for (
      var checkDate = startDate;
      checkDate.isBefore(endDate.add(const Duration(days: 1)));
      checkDate = checkDate.add(const Duration(days: 1))
    ) {
      // Entityのビジネスロジックを実行
      final calendarDay = calendarData.getCalendarDayForDate(checkDate);

      // // メンバーインデックス取得
      // final memberColorIndex =
      //     calendarDay.memberName != null
      //         ? rotationGroup.getMemberIndex(calendarDay.memberName!)
      //         : 0;

      final key = TimeUtils.createDateKey(checkDate);
      dayInfoMap[key] = calendarDay;
    }

    // 6. DTOに変換して返却
    return Results.success(
      CalendarResponse(
        dayInfoMap: dayInfoMap,
        rotationGroup: rotationGroup,
        userViewModelDto: UserResponse.fromEntity(appUser),
      ),
    );
  }
}
