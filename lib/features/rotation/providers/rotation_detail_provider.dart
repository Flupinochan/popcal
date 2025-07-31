import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';

part 'rotation_detail_provider.g.dart';

@riverpod
class RotationDetail extends _$RotationDetail {
  @override
  Future<RotationGroup?> build(
    String ownerUserId,
    String rotationGroupId,
  ) async {
    final repository = ref.read(rotationRepositoryProvider);
    final result = await repository.getRotationGroup(
      ownerUserId,
      rotationGroupId,
    );

    return result.when(
      success: (group) => group,
      failure: (error) => throw Exception(error.toString()),
    );
  }
}
