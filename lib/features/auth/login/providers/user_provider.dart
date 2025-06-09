import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:popcal/features/auth/login/domain/entities/user.dart';
import 'package:popcal/features/auth/login/providers/auth_providers.dart';

part 'user_provider.g.dart';

@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  Future<Result<AppUser?>> build() async {
    _setupAuthListener();

    final authRepo = ref.read(authRepositoryProvider);
    final result = await authRepo.getUser();

    return result;
  }

  void _setupAuthListener() {
    ref.listen(authStateChangesProvider, (_, next) {
      next.whenData((result) {
        result.when(
          success: (user) => state = AsyncData(Result.success(user)),
          failure:
              (_) =>
                  state = AsyncData(
                    Result.failure(AuthFailure("ユーザ情報の取得に失敗しました")),
                  ),
        );
      });
    });
  }
}
