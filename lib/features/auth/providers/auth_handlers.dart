import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_handlers.g.dart';

// Stream Entity => Stream Dto
// UIでStreamを受け取る際に直接Entityを受け取らないようにする
// Dtoに変換して返却
@riverpod
Stream<Result<UserResponse?>> authStateChanges(Ref ref) {
  final entityStream = ref.watch(authRepositoryProvider).authStateChanges;

  return entityStream.asyncMap((entityResult) async {
    if (entityResult.isError) {
      return Result.error(entityResult.error);
    }

    if (entityResult.value == null) {
      return const Result.ok(null);
    }

    return Result.ok(UserResponse.fromEntity(entityResult.value!));
  });
}
