import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/failures/auth_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/auth/providers/auth_loader.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_loader.g.dart';

@riverpod
Future<Result<RotationDataResponse>> rotationDataResponse(
  Ref ref,
  RotationId? rotationId,
) async {
  // 1. ユーザ情報を取得
  final authResult = await ref.watch(authStateChangesProvider.future);
  if (authResult.isFailure) {
    return Results.failure(authResult.failureOrNull!);
  }
  final userDto = authResult.valueOrNull;
  if (userDto == null) {
    return Results.failure(const AuthFailure('未認証です'));
  }
  if (rotationId == null) {
    return Results.success(RotationDataResponse(userDto, null));
  }

  // 2. ローテーショングループ情報を取得
  // responseのuseridのため.create()で作成する必要はない
  final userId = UserId(userDto.userId);
  final rotationRepository = ref.watch(rotationRepositoryProvider);
  final rotationResult = await rotationRepository.getRotation(
    userId,
    rotationId,
  );
  if (rotationResult.isFailure) {
    return Results.failure(rotationResult.failureOrNull!);
  }

  final rotationResponse = RotationResponse.fromEntity(
    rotationResult.valueOrNull!,
  );
  return Results.success(RotationDataResponse(userDto, rotationResponse));
}

@riverpod
Stream<Result<List<RotationResponse>>> rotationResponsesStream(
  Ref ref,
  String userId,
) {
  final userIdResult = UserId(userId);
  final rotationRepository = ref.watch(rotationRepositoryProvider);
  return rotationRepository.watchRotations(userIdResult).asyncMap((
    entityResult,
  ) async {
    return entityResult.when(
      success: (rotations) {
        final dtoList = rotations.map(RotationResponse.fromEntity).toList();
        return Results.success(dtoList);
      },
      failure: Results.failure,
    );
  });
}

class RotationDataResponse {
  const RotationDataResponse(this.userDto, this.rotationResponse);
  final UserResponse userDto;
  final RotationResponse? rotationResponse;
}
