import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_loader.g.dart';

@riverpod
Future<Result<void>> notificationInitialization(Ref ref) async {
  final notificationRepository = ref.watch(notificationGatewayProvider);
  return notificationRepository.initializeNotification();
}
