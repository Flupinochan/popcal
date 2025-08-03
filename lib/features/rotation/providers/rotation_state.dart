import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/presentation/dto/view_rotation_group_dto.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_state.g.dart';

// Stream EntityはDtoに変換して返却
@riverpod
Stream<Result<List<ViewRotationGroupDto>>> rotationGroupListStream(
  Ref ref,
  String userId,
) {
  final rotationRepository = ref.watch(rotationRepositoryProvider);
  return rotationRepository.watchRotationGroups(userId).asyncMap((
    entityResult,
  ) async {
    return entityResult.when(
      success: (rotationGroups) {
        final dtoList =
            rotationGroups
                .map((entity) => ViewRotationGroupDto.fromEntity(entity))
                .toList();
        return Results.success(dtoList);
      },
      failure: (error) => Results.failure(error),
    );
  });
}
