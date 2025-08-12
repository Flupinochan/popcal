import 'package:popcal/core/utils/failures/rotation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_request.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/utils/time_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_notifier.g.dart';

@riverpod
class RotationNotifier extends _$RotationNotifier {
  TimeUtils get _timeUtils => ref.read(timeUtilsProvider);

  @override
  FutureOr<RotationResponse?> build() => null;

  Future<Result<RotationResponse>> createRotation(
    CreateRotationRequest dto,
  ) async {
    state = await AsyncValue.guard(() async {
      final currentTime = _timeUtils.now();

      final entityResult = dto.toEntity(currentTime: currentTime);
      if (entityResult.isFailure) {
        throw Exception(entityResult.displayText);
      }

      final useCaseResult = await ref
          .read(createRotationUseCaseProvider)
          .execute(entityResult.valueOrNull!);
      if (useCaseResult.isFailure) {
        throw Exception(useCaseResult.displayText);
      }

      return RotationResponse.fromEntity(useCaseResult.valueOrNull!);
    });

    return state.when(
      data: (response) => Results.success(response!),
      error: (error, _) => Results.failure(RotationFailure(error.toString())),
      loading: () => Results.failure(const RotationFailure('予期しないエラー')),
    );
  }

  Future<Result<RotationResponse>> updateRotation(
    UpdateRotationRequest dto,
  ) async {
    state = await AsyncValue.guard(() async {
      final currentTime = _timeUtils.now();

      final entityResult = dto.toEntity(currentTime: currentTime);
      if (entityResult.isFailure) {
        throw Exception(entityResult.displayText);
      }

      final useCaseResult = await ref
          .read(updateRotationUseCaseProvider)
          .execute(entityResult.valueOrNull!);
      if (useCaseResult.isFailure) {
        throw Exception(useCaseResult.displayText);
      }

      return RotationResponse.fromEntity(useCaseResult.valueOrNull!);
    });

    return state.when(
      data: (response) => Results.success(response!),
      error: (error, _) => Results.failure(RotationFailure(error.toString())),
      loading: () => Results.failure(const RotationFailure('予期しないエラー')),
    );
  }
}
