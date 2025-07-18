import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  RotationRepository get _rotationRepository =>
      ref.read(rotationRepositoryProvider);

  @override
  FutureOr<List<RotationGroup>?> build() {
    return null;
  }

  /// ローテーショングループを削除
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

  /// ローテーショングループを復元（再作成）
  Future<Result<RotationGroup>> restoreRotationGroup(
    RotationGroup rotationGroup,
  ) async {
    state = const AsyncLoading();

    final createUseCase = ref.read(createRotationGroupUseCaseProvider);

    // rotationGroupIdをnullにして新規作成として扱う
    final rotationGroupToCreate = rotationGroup.copyWith(
      rotationGroupId: null,
      createdAt: DateTime.now().toLocal(),
      updatedAt: DateTime.now().toLocal(),
    );

    final result = await createUseCase.execute(rotationGroupToCreate);

    result.when(
      success: (rotationGroup) {
        state = AsyncData([rotationGroup]);
      },
      failure: (error) {
        state = AsyncError(error, StackTrace.current);
      },
    );

    return result;
  }
}
