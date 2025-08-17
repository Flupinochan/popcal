import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';

part 'deadline_notifications_response.freezed.dart';

/// Deadline通知一覧表示用Response
@freezed
sealed class DeadlineNotificationsResponse
    with _$DeadlineNotificationsResponse {
  factory DeadlineNotificationsResponse({required String displayTime}) =
      _DeadlineNotificationsResponse;

  const DeadlineNotificationsResponse._();

  static List<DeadlineNotificationsResponse> fromEntity(
    List<NotificationEntry> entity,
  ) {
    return entity
        .map(
          (notificationEntry) => DeadlineNotificationsResponse(
            displayTime: notificationEntry.displayTime,
          ),
        )
        .toList();
  }
}
