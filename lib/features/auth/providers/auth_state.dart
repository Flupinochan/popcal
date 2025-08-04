import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/auth/presentation/model/user_view_model.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/providers/auth_provider.dart';

part 'auth_state.g.dart';

// Stream Entity => Stream Dto
// UIではDtoに変換して利用、直接Entityを扱わない
@riverpod
Stream<Result<UserViewModel?>> authStateForUI(Ref ref) {
  final entityStream = ref.watch(authRepositoryProvider).authStateChanges;

  return entityStream.asyncMap((entityResult) async {
    return entityResult.when(
      success: (entity) {
        if (entity == null) return Results.success(null);
        return Results.success(UserViewModel.fromEntity(entity));
      },
      failure: (error) => Results.failure(error),
    );
  });
}
