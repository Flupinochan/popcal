import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_view_model.g.dart';

@riverpod
class RotationViewModel extends _$RotationViewModel {
  @override
  FutureOr<RotationGroup?> build() {
    return null;
  }

  Future<Result<RotationGroup>> createRotationGroup(
    RotationGroup rotationGroup,
  ) async {
    state = const AsyncLoading();

    final rotationRepository = ref.read(rotationRepositoryProvider);
    final result = await rotationRepository.createRotationGroup(rotationGroup);

    result.when(
      success: (rotationGroup) {
        state = AsyncData(rotationGroup);
      },
      failure: (error) {
        state = AsyncError(error, StackTrace.current);
      },
    );

    return result;
  }
}
