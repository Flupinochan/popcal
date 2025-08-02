import 'package:popcal/features/auth/providers/auth_state.dart';
import 'package:popcal/features/calendar/domain/entities/calendar_data.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_data_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/providers/rotation_detail_provider.dart';

part 'calendar_screen_data.g.dart';

// CalendarScreen表示に必要な3つの情報を取得して返却
// 画面表示時に取得する3つの非同期データを1つの.when()にまとめる
// ※リアルタイムで画面更新が必要ないため全てを初期取得1回にする
@riverpod
Future<Result<CalendarDataDto>> calendarScreenData(
  Ref ref,
  String rotationGroupId,
) async {
  // 1. ユーザ情報を取得 ※.futureでstreamから1度だけ取得が可能
  final authResult = await ref.watch(authStateForUIProvider.future);
  if (authResult.isFailure) {
    return Results.failure(authResult.failureOrNull!);
  }
  final userViewModelDto = authResult.valueOrNull;
  if (userViewModelDto == null) {
    return Results.failure(AuthFailure('未認証です'));
  }

  final userEntityResult = userViewModelDto.toEntity();
  if (userEntityResult.isFailure) {
    return Results.failure(userEntityResult.failureOrNull!);
  }
  final appUser = userEntityResult.valueOrNull!;

  // 2. ローテーション情報取得 ※ユーザ情報はここで利用
  final rotationGroup = await ref.watch(
    rotationDetailProvider(appUser.uidValue, rotationGroupId).future,
  );
  if (rotationGroup == null) {
    return Results.failure(ValidationFailure('ローテーション情報が見つかりません'));
  }

  // 3. 通知情報取得
  final notificationDetails = await ref.watch(
    calendarNotificationDetailsProvider(rotationGroup).future,
  );

  // 4. Dtoで返却
  final calendarDataEntity = CalendarData(
    appUser: appUser,
    rotationGroup: rotationGroup,
    notificationDetails: notificationDetails,
  );
  final calendarDataDto = CalendarDataDto.fromEntity(calendarDataEntity);
  return Results.success(calendarDataDto);
}
