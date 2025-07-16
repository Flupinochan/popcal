import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/use_cases/create_rotation_group_use_case.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_view_model.g.dart';

@riverpod
class RotationViewModel extends _$RotationViewModel {
  // use caseへのgetterを定義
  CreateRotationGroupUseCase get _createRotationGroupUseCase =>
      ref.read(createRotationGroupUseCaseProvider);

  @override
  FutureOr<RotationGroup?> build() {
    return null;
  }

  // 4. ローテーショングループ作成
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
        print(error);
      },
    );

    return result;
  }
}
