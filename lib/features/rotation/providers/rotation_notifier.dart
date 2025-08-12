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
  FutureOr<Result<RotationResponse>?> build() => null;

  // RotationResponseはreturnせずstateに値を格納する
  Future<void> createRotation(
    CreateRotationRequest dto,
  ) async {
    state = await AsyncValue.guard(() async {
      final currentTime = _timeUtils.now();

      final entityResult = dto.toEntity(currentTime: currentTime);
      if (entityResult.isFailure) {
        return Results.failure(RotationFailure(entityResult.displayText));
      }

      final useCaseResult = await ref
          .read(createRotationUseCaseProvider)
          .execute(entityResult.valueOrNull!);
      if (useCaseResult.isFailure) {
        return Results.failure(RotationFailure(useCaseResult.displayText));
      }

      return Results.success(
        RotationResponse.fromEntity(useCaseResult.valueOrNull!),
      );
    });
  }

  Future<void> updateRotation(
    UpdateRotationRequest dto,
  ) async {
    state = await AsyncValue.guard(() async {
      final currentTime = _timeUtils.now();

      final entityResult = dto.toEntity(currentTime: currentTime);
      if (entityResult.isFailure) {
        return Results.failure(RotationFailure(entityResult.displayText));
      }

      final useCaseResult = await ref
          .read(updateRotationUseCaseProvider)
          .execute(entityResult.valueOrNull!);
      if (useCaseResult.isFailure) {
        return Results.failure(RotationFailure(useCaseResult.displayText));
      }

      return Results.success(
        RotationResponse.fromEntity(useCaseResult.valueOrNull!),
      );
    });
  }
}
