import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/domain/repositories/deadline_repository.dart';
import 'package:popcal/features/deadline/domain/services/deadline_calculation_service.dart';
import 'package:popcal/features/deadline/domain/services/deadline_calculation_service_impl.dart';
import 'package:popcal/features/deadline/infrastructure/repositories/deadline_shared_preferences.dart';
import 'package:popcal/features/deadline/infrastructure/repositories/deadline_shared_preferences_impl.dart';
import 'package:popcal/features/deadline/use_case/toggle_deadline_use_case.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'deadline_providers.g.dart';

@riverpod
DeadlineCalculationService deadlineCalculationService(Ref _) {
  return DeadlineCalculationServiceImpl(Logger('DeadlineCalculationService'));
}

@Riverpod(keepAlive: true)
DeadlineRepository deadlineRepository(Ref ref) {
  return DeadlineSharedPreferencesImpl(
    ref.watch(deadlineSharedPreferencesProvider),
  );
}

@Riverpod(keepAlive: true)
DeadlineSharedPreferences deadlineSharedPreferences(Ref ref) {
  return DeadlineSharedPreferences(ref.watch(sharedPreferencesProvider));
}

@riverpod
Future<Result<List<NotificationEntry>>> getDeadlineNotifications(
  Ref ref,
) {
  return ref
      .watch(notificationGatewayProvider)
      .getNotificationsBySourceId(SourceId.createDeadlineId());
}

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref _) {
  /// SharedPreferencesの初期化が非同期のためmain.dartでoverrideして初期化
  throw UnimplementedError('main.dartでSharedPreferencesが初期化されていません');
}

@riverpod
ToggleDeadlineUseCase toggleDeadlineUseCase(Ref ref) {
  return ToggleDeadlineUseCase(
    ref.watch(deadlineRepositoryProvider),
    ref.watch(deadlineCalculationServiceProvider),
    ref.watch(notificationGatewayProvider),
  );
}
