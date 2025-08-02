import 'package:popcal/features/auth/presentation/dto/user_view_model_dto.dart';
import 'package:popcal/features/auth/providers/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/notifications/domain/entities/notification_detail.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_detail_provider.dart';

part 'calendar_data.g.dart';

// CalendarScreen表示に必要な3つの情報を取得して返却
// 画面表示時に取得する3つの非同期データを1つのローディングにまとめる
// ※リアルタイムで画面更新が必要ないため全てを初期取得1回にする
// .when()用初期画面表示用データ取得
@riverpod
Future<Result<CalendarData>> calendarData(
  Ref ref,
  String rotationGroupId,
) async {
  // 1. ユーザ情報を取得 ※futureで1度だけ取得が可能
  final authResult = await ref.watch(authStateForUIProvider.future);
  if (authResult.isFailure) {
    return Results.failure(authResult.failureOrNull!);
  }
  final userDto = authResult.valueOrNull;
  if (userDto == null) {
    return Results.failure(AuthFailure('未認証です'));
  }

  // 2. ローテーション情報取得 ※ユーザ情報はここで利用
  final rotationGroup = await ref.watch(
    rotationDetailProvider(userDto.userId.value, rotationGroupId).future,
  );
  if (rotationGroup == null) {
    return Results.failure(ValidationFailure('ローテーション情報が見つかりません'));
  }

  // 3. 通知情報取得
  final notificationResult = await ref.watch(
    calendarNotificationDetailsProvider(rotationGroup).future,
  );

  final calendarData = CalendarData(userDto, rotationGroup, notificationResult);

  return Results.success(calendarData);
}

class CalendarData {
  final UserViewModelDto userDto;
  final RotationGroup rotationGroup;
  final List<NotificationDetail> notificationDetails;

  const CalendarData(
    this.userDto,
    this.rotationGroup,
    this.notificationDetails,
  );
}
