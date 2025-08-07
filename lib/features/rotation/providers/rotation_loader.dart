import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/auth/providers/auth_state.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_loader.g.dart';

@riverpod
Future<Result<RotationDataResponse>> rotationDataResponse(
  Ref ref,
  String? rotationId,
) async {
  // 1. ユーザ情報を取得
  final authResult = await ref.watch(authStateForUIProvider.future);
  if (authResult.isFailure) {
    return Results.failure(authResult.failureOrNull!);
  }
  final userDto = authResult.valueOrNull;
  if (userDto == null) {
    return Results.failure(AuthFailure('未認証です'));
  }
  if (rotationId == null) {
    return Results.success(RotationDataResponse(userDto, null));
  }

  // 2. ローテーショングループ情報を取得
  final rotationRepository = ref.watch(rotationRepositoryProvider);
  final rotationResult = await rotationRepository.getRotation(
    userDto.userId.value,
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

class RotationDataResponse {
  final UserResponse userDto;
  final RotationResponse? rotationResponse;

  const RotationDataResponse(this.userDto, this.rotationResponse);
}
