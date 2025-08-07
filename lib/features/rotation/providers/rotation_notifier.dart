import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_request.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';

part 'rotation_notifier.g.dart';

// EntityとDtoの変換処理を担当
@riverpod
class RotationNotifier extends _$RotationNotifier {
  @override
  FutureOr<void> build() => null;

  // 作成
  Future<Result<RotationResponse>> createRotation(
    CreateRotationRequest dto,
  ) async {
    state = const AsyncLoading();
    try {
      final entityResult = dto.toEntity();
      if (entityResult.isFailure) {
        state = AsyncError(entityResult.failureOrNull!, StackTrace.current);
        return Results.failure(RotationFailure(entityResult.displayText));
      }

      final result = await ref
          .read(createRotationUseCaseProvider)
          .execute(entityResult.valueOrNull!);
      state = const AsyncData(null);
      return _convertEntityToDto(result);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  // 更新
  Future<Result<RotationResponse>> updateRotation(
    UpdateRotationRequest dto,
  ) async {
    state = const AsyncLoading();
    try {
      final entityResult = dto.toEntity();
      if (entityResult.isFailure) {
        state = AsyncError(entityResult.failureOrNull!, StackTrace.current);
        return Results.failure(RotationFailure(entityResult.displayText));
      }
      final result = await ref
          .read(updateRotationUseCaseProvider)
          .execute(entityResult.valueOrNull!);
      state = const AsyncData(null);
      return _convertEntityToDto(result);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Result<RotationResponse> _convertEntityToDto(Result<Rotation> entityResult) {
    return entityResult.when(
      success:
          (appUser) => Results.success(RotationResponse.fromEntity(appUser)),
      failure: (error) => Results.failure(RotationFailure(error.message)),
    );
  }
}
