import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';

part 'user_provider.g.dart';

@riverpod
class CurrentUser extends _$CurrentUser {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  @override
  Future<Result<AppUser?>> build() async {
    _setupAuthListener();

    final result = await _authRepository.getUser();

    return result;
  }

  void _setupAuthListener() {
    ref.listen(authStateChangesProvider, (_, next) {
      next.whenData((result) {
        result.when(
          success: (user) => state = AsyncData(Results.success(user)),
          failure:
              (_) =>
                  state = AsyncData(
                    Results.failure(AuthFailure("ユーザ情報の取得に失敗しました")),
                  ),
        );
      });
    });
  }
}
