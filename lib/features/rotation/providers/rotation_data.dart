import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/data/dto/user_dto.dart';
import 'package:popcal/features/auth/providers/auth_state.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_detail_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rotation_data.g.dart';

@riverpod
Future<Result<RotationData>> rotationData(
  Ref ref,
  String? rotationGroupId,
) async {
  // 1. ユーザ情報を取得
  final authResult = await ref.watch(authStateForUIProvider.future);
  if (authResult.isFailure) {
    return Results.failure(authResult.failureOrNull!);
  }
  final userDto = authResult.valueOrNull;
  if (userDto == null) {
    return Results.failure(AuthFailure('未認証です'));
  }

  if (rotationGroupId == null) {
    return Results.success(RotationData(userDto, null));
  } else {
    // 2. ローテーショングループ情報を取得
    final rotationGroup = await ref.watch(
      rotationDetailProvider(userDto.uid.value, rotationGroupId).future,
    );
    if (rotationGroup == null) {
      return Results.failure(ValidationFailure('ローテーション情報が見つかりません'));
    }
    return Results.success(RotationData(userDto, rotationGroup));
  }
}

class RotationData {
  final UserDto userDto;
  final RotationGroup? rotationGroup;

  const RotationData(this.userDto, this.rotationGroup);
}
