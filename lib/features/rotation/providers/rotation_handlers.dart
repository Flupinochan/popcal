import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/exceptions/auth_exception.dart';
import 'package:popcal/core/utils/exceptions/rotation_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/auth/providers/auth_handlers.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_handlers.g.dart';

@riverpod
Future<Result<RotationDataResponse>> rotationDataResponse(
  Ref ref,
  String? rotationId,
) async {
  // 1. ユーザ情報を取得
  final authResult = await ref.watch(authStateChangesProvider.future);
  if (authResult.isError) {
    return Result.error(authResult.error);
  }
  final userDto = authResult.value;
  if (userDto == null) {
    return const Result.error(AuthException('未認証です'));
  }
  if (rotationId == null) {
    return Result.ok(RotationDataResponse(userDto, null));
  }

  // 2. ローテーショングループ情報を取得
  final userIdResult = UserId.create(userDto.userId);
  if (userIdResult.isError) {
    return Result.error(userIdResult.error);
  }

  final rotationIdResult = RotationId.create(rotationId);
  if (rotationIdResult.isError) {
    return Result.error(rotationIdResult.error);
  }

  final rotationRepository = ref.watch(rotationRepositoryProvider);
  final rotationResult = await rotationRepository.getRotation(
    userIdResult.value,
    rotationIdResult.value,
  );
  if (rotationResult.isError) {
    return Result.error(rotationResult.error);
  }

  final rotation = rotationResult.value;
  if (rotation == null) {
    return const Result.error(RotationException('ローテーション情報が取得できませんでした'));
  }

  final rotationResponse = RotationResponse.fromEntity(rotation);
  return Result.ok(RotationDataResponse(userDto, rotationResponse));
}

@riverpod
Stream<Result<List<RotationResponse>>> rotationResponsesStream(
  Ref ref,
  String userId,
) {
  final userIdResult = UserId.create(userId);
  if (userIdResult.isError) {
    return Stream.value(
      Result.error(userIdResult.error),
    );
  }

  final rotationRepository = ref.watch(rotationRepositoryProvider);
  return rotationRepository.watchRotations(userIdResult.value).asyncMap((
    entityResult,
  ) async {
    if (entityResult.isError) {
      return Result.error(entityResult.error);
    }

    final entity = entityResult.value;

    final dtoList = entity.map(RotationResponse.fromEntity).toList();
    return Result.ok(dtoList);
  });
}

class RotationDataResponse {
  const RotationDataResponse(this.userDto, this.rotationResponse);

  final UserResponse userDto;
  final RotationResponse? rotationResponse;
}
