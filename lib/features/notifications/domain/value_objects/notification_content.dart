import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';

part 'notification_content.freezed.dart';
part 'notification_content.g.dart';

@freezed
sealed class NotificationContent with _$NotificationContent {
  const factory NotificationContent({
    required String value,
  }) = _NotificationContent;

  factory NotificationContent.fromJson(Map<String, dynamic> json) =>
      _$NotificationContentFromJson(json);

  const NotificationContent._();

  static Result<NotificationContent> createFromRotationMemberName(
    RotationMemberName rotationMemberName,
  ) {
    try {
      return Results.success(
        NotificationContent(
          value: rotationMemberName.getNotificationContent(),
        ),
      );
    } on Exception catch (error) {
      return Results.failure(
        NotificationFailure(
          'RotationMemberNameからContentへの変換に失敗しました: $error',
        ),
      );
    }
  }
}
