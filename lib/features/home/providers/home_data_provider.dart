import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'home_data_provider.g.dart';

@riverpod
Future<Result<HomeData>> homeData(Ref ref) async {
  // 1. ユーザ情報を取得
  final authResult = await ref.watch(authStateChangesProvider.future);
  if (authResult.isFailure) {
    return Results.failure(authResult.failureOrNull!);
  }
  final user = authResult.valueOrNull;
  if (user == null) {
    return Results.failure(AuthFailure('未認証です'));
  }

  // 2. ローテーション一覧を取得
  final rotationGroupsResult = await ref.watch(
    rotationGroupsStreamProvider(user.uid).future,
  );
  if (rotationGroupsResult.isFailure) {
    return Results.failure(rotationGroupsResult.failureOrNull!);
  }
  final rotationGroups = rotationGroupsResult.valueOrNull;
  if (rotationGroups == null) {
    return Results.failure(RotationGroupFailure('ローテーション一覧の取得に失敗しました'));
  }

  // 3. 通知同期処理
  final syncUseCase = ref.watch(syncNotificationsUseCaseProvider);
  final syncUseCaseResult = await syncUseCase.execute(user.uid);
  if (syncUseCaseResult.isFailure) {
    return Results.failure(syncUseCaseResult.failureOrNull!);
  }

  final homeData = HomeData(user: user, rotationGroups: rotationGroups);

  return Results.success(homeData);
}

class HomeData {
  final AppUser user;
  final List<RotationGroup> rotationGroups;

  const HomeData({required this.user, required this.rotationGroups});
}
