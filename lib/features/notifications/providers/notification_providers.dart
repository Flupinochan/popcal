import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/core/providers/core_provider.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/domain/gateways/notification_gateway.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service.dart';
import 'package:popcal/features/notifications/domain/services/rotation_calculation_service_impl.dart';
import 'package:popcal/features/notifications/infrastructure/gateways/notification_gateway_impl.dart';
import 'package:popcal/features/notifications/infrastructure/gateways/notification_gateway_local.dart';
import 'package:popcal/features/notifications/use_cases/sync_notifications_use_case.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/router/router.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_providers.g.dart';

@riverpod
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin(Ref _) {
  return FlutterLocalNotificationsPlugin();
}

@riverpod
NotificationGateway notificationGateway(Ref ref) {
  return NotificationGatewayImpl(ref.watch(notificationGatewayLocalProvider));
}

@riverpod
NotificationGatewayLocal notificationGatewayLocal(Ref ref) {
  return NotificationGatewayLocal(
    ref.watch(routerProvider(initialLocation: const HomeRoute().location)),
    ref.watch(flutterLocalNotificationsPluginProvider),
    ref.watch(loggerProvider('NotificationGatewayLocal')),
    ref.watch(timeUtilsProvider),
  );
}

@riverpod
Future<Result<void>> notificationInitialization(Ref ref) async {
  final notificationRepository = ref.watch(notificationGatewayProvider);
  return notificationRepository.initializeNotification();
}

@riverpod
RotationCalculationService rotationCalculationService(Ref ref) {
  return RotationCalculationServiceImpl(ref.watch(timeUtilsProvider));
}

@riverpod
SyncNotificationsUseCase syncNotificationsUseCase(Ref ref) {
  return SyncNotificationsUseCase(
    ref.watch(rotationRepositoryProvider),
    ref.watch(notificationGatewayProvider),
    ref.watch(rotationCalculationServiceProvider),
  );
}
