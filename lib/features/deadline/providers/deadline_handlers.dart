import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/deadline/presentation/dto/deadline_notifications_response.dart';
import 'package:popcal/features/notifications/domain/value_objects/sourceid.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deadline_handlers.g.dart';

@riverpod
Future<Result<List<DeadlineNotificationsResponse>>> getDeadlineNotifications(
  Ref ref,
) async {
  final result = await ref
      .watch(notificationGatewayProvider)
      .getNotificationsBySourceId(GroupId.createDeadlineId());
  if (result.isError) {
    return Result.error(result.error);
  }
  return Result.ok(
    DeadlineNotificationsResponse.fromEntity(result.value),
  );
}
