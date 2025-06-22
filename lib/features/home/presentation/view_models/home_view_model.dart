import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  FutureOr<List<RotationGroup>?> build() {
    return null;
  }

  RotationRepository get _rotationRepository =>
      ref.read(rotationRepositoryProvider);

  // Streamでリアルタイム取得するため未使用
  Future<Result<List<RotationGroup>>> getRotationGroups(
    String ownerUserId,
  ) async {
    state = const AsyncLoading();

    final result = await _rotationRepository.getRotationGroups(ownerUserId);

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

  // 6. ローテーショングループ削除
  Future<Result<void>> deleteRotationGroup(
    String ownerUserId,
    String rotationGroupId,
  ) async {
    state = const AsyncLoading();

    final result = await _rotationRepository.deleteRotationGroup(
      ownerUserId,
      rotationGroupId,
    );

    result.when(
      success: (_) {
        state = const AsyncData(null);
      },
      failure: (error) {
        state = AsyncError(error, StackTrace.current);
      },
    );

    return result;
  }
}
