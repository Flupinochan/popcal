import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/use_cases/create_rotation_group_use_case.dart';
import 'package:popcal/features/rotation/domain/use_cases/update_rotation_group_use_case.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_view_model.g.dart';

@riverpod
class RotationViewModel extends _$RotationViewModel {
  CreateRotationGroupUseCase get _createRotationGroupUseCase =>
      ref.read(createRotationGroupUseCaseProvider);

  UpdateRotationGroupUseCase get _updateRotationGroupUseCase =>
      ref.read(updateRotationGroupUseCaseProvider);

  @override
  FutureOr<RotationGroup?> build() {
    return null;
  }

  /// ローテーショングループを作成
  Future<Result<RotationGroup>> createRotationGroup(
    RotationGroup rotationGroup,
  ) async {
    state = const AsyncLoading();

    final result = await _createRotationGroupUseCase.execute(rotationGroup);

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

  /// ローテーショングループを更新
  Future<Result<RotationGroup>> updateRotationGroup(
    RotationGroup rotationGroup,
  ) async {
    state = const AsyncLoading();

    final result = await _updateRotationGroupUseCase.execute(rotationGroup);

    result.when(
      success: (updatedRotationGroup) {
        state = AsyncData(updatedRotationGroup);
      },
      failure: (error) {
        state = AsyncError(error, StackTrace.current);
      },
    );

    return result;
  }
}
