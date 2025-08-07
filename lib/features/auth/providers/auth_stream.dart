import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';

part 'auth_stream.g.dart';

// Stream Entity => Stream Dto
// UIでStreamを受け取る際に直接Entityを受け取らないようにする
// Dtoに変換して返却
@riverpod
Stream<Result<UserResponse?>> authStateForUI(Ref ref) {
  final entityStream = ref.watch(authRepositoryProvider).authStateChanges;

  return entityStream.asyncMap((entityResult) async {
    return entityResult.when(
      success: (entity) {
        if (entity == null) return Results.success(null);
        return Results.success(UserResponse.fromEntity(entity));
      },
      failure: (error) => Results.failure(error),
    );
  });
}
