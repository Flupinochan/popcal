import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_group_dto.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_group_dto.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';

part 'rotation_controller.g.dart';

@riverpod
class RotationController extends _$RotationController {
  @override
  FutureOr<void> build() => null;

  // 作成
  Future<Result<RotationGroup>> createRotationGroup(
    CreateRotationGroupDto dto,
  ) async {
    state = const AsyncLoading();
    try {
      final result = await ref
          .read(createRotationGroupUseCaseProvider)
          .execute(dto);
      state = const AsyncData(null);
      return result;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  // 更新
  Future<Result<RotationGroup>> updateRotationGroup(
    UpdateRotationGroupDto dto,
  ) async {
    state = const AsyncLoading();
    try {
      final result = await ref
          .read(updateRotationGroupUseCaseProvider)
          .execute(dto);
      state = const AsyncData(null);
      return result;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}
