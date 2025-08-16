import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/features/notifications/domain/entities/notification_entry.dart';

part 'deadline_response.freezed.dart';

@freezed
sealed class DeadlineResponse with _$DeadlineResponse {
  factory DeadlineResponse({required String displayTime}) = _DeadlineResponse;

  const DeadlineResponse._();

  static List<DeadlineResponse> fromEntity(List<NotificationEntry> entity) {
    return entity
        .map(
          (notificationEntry) =>
              DeadlineResponse(displayTime: notificationEntry.displayTime),
        )
        .toList();
  }
}
