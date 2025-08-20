import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_rotation_notifier.g.dart';

@riverpod
class SyncRotationNotifier extends _$SyncRotationNotifier {
  @override
  FutureOr<Result<void>?> build() async => null;

  Future<void> syncRotation(String userId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userIdResult = UserId.create(userId);
      if (userIdResult.isError) {
        return Result.error(userIdResult.error);
      }

      final syncResult = await ref
          .watch(syncNotificationsUseCaseProvider)
          .execute(userIdResult.value);
      if (syncResult.isError) {
        return Result.error(syncResult.error);
      }

      return const Result.ok(null);
    });
  }
}
