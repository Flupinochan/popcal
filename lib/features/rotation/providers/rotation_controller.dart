import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_group_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_group_request.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_group_request.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';

part 'rotation_controller.g.dart';

@riverpod
class RotationController extends _$RotationController {
  @override
  FutureOr<void> build() => null;

  // 作成
  Future<Result<RotationGroupResponse>> createRotationGroup(
    CreateRotationGroupRequest dto,
  ) async {
    state = const AsyncLoading();
    try {
      final result = await ref
          .read(createRotationGroupUseCaseProvider)
          .execute(dto);
      state = const AsyncData(null);
      return _convertEntityToDto(result);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  // 更新
  Future<Result<RotationGroupResponse>> updateRotationGroup(
    UpdateRotationGroupRequest dto,
  ) async {
    state = const AsyncLoading();
    try {
      final result = await ref
          .read(updateRotationGroupUseCaseProvider)
          .execute(dto);
      state = const AsyncData(null);
      return _convertEntityToDto(result);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Result<RotationGroupResponse> _convertEntityToDto(
    Result<RotationGroup> entityResult,
  ) {
    return entityResult.when(
      success:
          (appUser) =>
              Results.success(RotationGroupResponse.fromEntity(appUser)),
      failure: (error) => Results.failure(RotationGroupFailure(error.message)),
    );
  }
}
