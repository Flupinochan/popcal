import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/notifications/data/datasource/local_notifications_datasource.dart';
import 'package:popcal/features/notifications/data/repositories/notification_repository_local.dart';
import 'package:popcal/features/notifications/domain/repositories/notification_repository.dart';
import 'package:popcal/features/notifications/domain/use_cases/sync_notifications_use_case.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/router/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_providers.g.dart';

@riverpod
LocalNotificationsDatasource localNotificationsDatasource(Ref ref) {
  return LocalNotificationsDatasource(ref.watch(routerProvider));
}

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepositoryLocal(
    ref.watch(localNotificationsDatasourceProvider),
  );
}

@riverpod
SyncNotificationsUseCase syncNotificationsUseCase(Ref ref) {
  return SyncNotificationsUseCase(
    ref.watch(rotationRepositoryProvider),
    ref.watch(notificationRepositoryProvider),
  );
}
