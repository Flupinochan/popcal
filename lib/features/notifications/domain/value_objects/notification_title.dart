import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';

part 'notification_title.freezed.dart';
part 'notification_title.g.dart';

@freezed
sealed class NotificationTitle with _$NotificationTitle {
  const factory NotificationTitle({
    required String value,
  }) = _NotificationTitle;

  factory NotificationTitle.fromJson(Map<String, dynamic> json) =>
      _$NotificationTitleFromJson(json);

  const NotificationTitle._();

  static Result<NotificationTitle> createFromRotationName(
    RotationName rotationName,
  ) {
    try {
      return Results.success(
        NotificationTitle(value: rotationName.getNotificationTitle()),
      );
    } on Exception catch (error) {
      return Results.failure(
        NotificationFailure('rotationNameからTitleへの変換に失敗しました: $error'),
      );
    }
  }
}
