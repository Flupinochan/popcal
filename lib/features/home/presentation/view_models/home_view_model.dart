import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  FutureOr<List<RotationGroup>?> build() {
    return null;
  }

  Future<Result<List<RotationGroup>>> getRotationGroups(
    String ownerUserId,
  ) async {
    state = const AsyncLoading();

    final rotationRepository = ref.read(rotationRepositoryProvider);
    final result = await rotationRepository.getRotationGroups(ownerUserId);

    result.when(
      success: (rotationGroups) {
        state = AsyncData(rotationGroups);
      },
      failure: (error) {
        state = AsyncError(error, StackTrace.current);
      },
    );

    return result;
  }
}
