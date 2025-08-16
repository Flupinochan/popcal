import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

part 'notification_description.freezed.dart';
part 'notification_description.g.dart';

@freezed
sealed class NotificationDescription with _$NotificationDescription {
  const factory NotificationDescription({
    required String value,
  }) = _NotificationDescription;

  factory NotificationDescription.fromJson(Map<String, dynamic> json) =>
      _$NotificationDescriptionFromJson(json);

  static Result<NotificationDescription> createFromRotationName(
    RotationName rotationName,
  ) {
    try {
      return Results.success(
        NotificationDescription(
          value: rotationName.getNotificationDescription(),
        ),
      );
    } on Exception catch (error) {
      return Results.failure(
        NotificationFailure('rotationNameからDescriptionへの変換に失敗しました: $error'),
      );
    }
  }
}
