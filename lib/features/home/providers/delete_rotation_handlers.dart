import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_rotation_handlers.g.dart';

/// state管理不要な削除メソッド
@riverpod
Future<Result<void>> deleteRotation(
  Ref ref,
  String userId,
  String rotationId,
) async {
  final userIdResult = UserId.create(userId);
  if (userIdResult.isError) {
    return Result.error(userIdResult.error);
  }

  final rotationIdResult = RotationId.create(rotationId);
  if (rotationIdResult.isError) {
    return Result.error(rotationIdResult.error);
  }

  final syncResult = await ref
      .watch(rotationRepositoryProvider)
      .deleteRotation(
        userIdResult.value,
        rotationIdResult.value,
      );
  if (syncResult.isError) {
    return Result.error(syncResult.error);
  }

  return const Result.ok(null);
}
