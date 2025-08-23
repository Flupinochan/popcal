import 'package:mocktail/mocktail.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/user_id.dart';
import 'package:popcal/features/notifications/use_cases/sync_notifications_use_case.dart';

class MockSyncNotificationsUseCase extends Mock
    implements SyncNotificationsUseCase {
  @override
  Future<Result<void>> execute(UserId userId) async {
    return const Result.ok(null);
  }
}
