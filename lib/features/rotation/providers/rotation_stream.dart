import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_stream.g.dart';

@riverpod
Stream<Result<List<RotationResponse>>> rotationResponsesStream(
  Ref ref,
  UserId userId,
) {
  final rotationRepository = ref.watch(rotationRepositoryProvider);
  return rotationRepository.watchRotations(userId).asyncMap((
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
