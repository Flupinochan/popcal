import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_detail_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_data_provider.g.dart';

@riverpod
Future<Result<RotationData>> rotationData(
  Ref ref,
  String? rotationGroupId,
) async {
  // 1. ユーザ情報を取得
  final authResult = await ref.watch(authStateChangesProvider.future);
  if (authResult.isFailure) {
    return Results.failure(authResult.failureOrNull!);
  }
  final appUser = authResult.valueOrNull;
  if (appUser == null) {
    return Results.failure(AuthFailure('未認証です'));
  }

  if (rotationGroupId == null) {
    return Results.success(RotationData(appUser, null));
  } else {
    // 2. ローテーショングループ情報を取得
    final rotationGroup = await ref.watch(
      rotationDetailProvider(appUser.uid, rotationGroupId).future,
    );
    if (rotationGroup == null) {
      return Results.failure(ValidationFailure('ローテーション情報が見つかりません'));
    }
    return Results.success(RotationData(appUser, rotationGroup));
  }
}

class RotationData {
  final AppUser appUser;
  final RotationGroup? rotationGroup;

  const RotationData(this.appUser, this.rotationGroup);
}
