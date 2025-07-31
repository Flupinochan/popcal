import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/notifications/domain/entities/notification_detail.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_detail_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_providers.g.dart';

// CalendarScreen表示に必要な3つの情報を取得して返却
// 3つの非同期データ取得を1つのローディングにまとめる
@riverpod
Future<Result<CalendarData>> calendarData(
  Ref ref,
  String rotationGroupId,
) async {
  try {
    // 1. ユーザ情報を取得 ※futureで1度だけ取得が可能
    final authResult = await ref.watch(authStateChangesProvider.future);
    if (authResult.isFailure) {
      return Results.failure(authResult.failureOrNull!);
    }
    final user = authResult.valueOrNull;
    if (user == null) {
      return Results.failure(AuthFailure('未認証です'));
    }

    // 2. ローテーション情報取得 ※ユーザ情報はここで利用
    final rotationResult = await ref.watch(
      rotationDetailProvider(user.uid, rotationGroupId).future,
    );
    if (rotationResult == null) {
      return Results.failure(ValidationFailure('ローテーション情報が見つかりません'));
    }

    // 3. 通知情報取得
    final notificationResult = await ref.watch(
      calendarNotificationDetailsProvider(rotationResult).future,
    );

    final calendarData = CalendarData(
      user: user,
      rotationGroup: rotationResult,
      notificationDetails: notificationResult,
    );

    return Results.success(calendarData);
  } catch (error) {
    return Results.failure(NetworkFailure('カレンダーデータの取得に失敗しました: $error'));
  }
}

class CalendarData {
  final AppUser user;
  final RotationGroup rotationGroup;
  final List<NotificationDetail> notificationDetails;

  const CalendarData({
    required this.user,
    required this.rotationGroup,
    required this.notificationDetails,
  });
}
