import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/repositories/rotation_repository.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_view_model.g.dart';

@riverpod
class RotationViewModel extends _$RotationViewModel {
  @override
  FutureOr<RotationGroup?> build() {
    return null;
  }

  // repositoryへのgetterを定義
  RotationRepository get _rotationRepository =>
      ref.read(rotationRepositoryProvider);

  // 4. ローテーショングループ作成
  Future<Result<RotationGroup>> createRotationGroup(
    RotationGroup rotationGroup,
  ) async {
    state = const AsyncLoading();

    final result = await _rotationRepository.createRotationGroup(rotationGroup);

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
