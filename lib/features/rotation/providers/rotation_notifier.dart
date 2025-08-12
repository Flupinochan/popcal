import 'package:popcal/core/utils/failures/rotation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/entities/rotation.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_request.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/utils/time_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_notifier.g.dart';

// EntityとDtoの変換処理を担当
@riverpod
class RotationNotifier extends _$RotationNotifier {
  TimeUtils get _timeUtils => ref.read(timeUtilsProvider);

  @override
  FutureOr<void> build() => null;

  // 作成
  Future<Result<RotationResponse>> createRotation(
    CreateRotationRequest dto,
  ) async {
    final result = await AsyncValue.guard<Result<RotationResponse>>(() async {
      final currentTime = _timeUtils.now();
      final entityResult = dto.toEntity(currentTime: currentTime);

      if (entityResult.isFailure) {
        return Results.failure(RotationFailure(entityResult.displayText));
      }

      final useCaseResult = await ref
          .read(createRotationUseCaseProvider)
          .execute(entityResult.valueOrNull!);

      return _convertEntityToDto(useCaseResult);
    });

    state = result;

    return result.when(
      data: (value) => value,
      error: (error, _) => Results.failure(RotationFailure(error.toString())),
      loading:
          () => Results.failure<RotationResponse>(
            const RotationFailure('処理中にエラーが発生しました'),
          ),
    );
  }

  // 更新
  Future<Result<RotationResponse>> updateRotation(
    UpdateRotationRequest dto,
  ) async {
    final result = await AsyncValue.guard<Result<RotationResponse>>(() async {
      final currentTime = _timeUtils.now();
      final entityResult = dto.toEntity(currentTime: currentTime);

      if (entityResult.isFailure) {
        return Results.failure(RotationFailure(entityResult.displayText));
      }

      final useCaseResult = await ref
          .read(updateRotationUseCaseProvider)
          .execute(entityResult.valueOrNull!);

      return _convertEntityToDto(useCaseResult);
    });

    state = result;

    return result.when(
      data: (value) => value,
      error: (error, _) => Results.failure(RotationFailure(error.toString())),
      loading:
          () => Results.failure<RotationResponse>(
            const RotationFailure('処理中にエラーが発生しました'),
          ),
    );
  }

  Result<RotationResponse> _convertEntityToDto(Result<Rotation> entityResult) {
    return entityResult.when(
      success:
          (appUser) => Results.success(RotationResponse.fromEntity(appUser)),
      failure: (error) => Results.failure(RotationFailure(error.message)),
    );
  }
}
