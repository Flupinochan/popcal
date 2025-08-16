import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/notification_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';

part 'sourceid.freezed.dart';
part 'sourceid.g.dart';

@freezed
sealed class SourceId with _$SourceId {
  const factory SourceId({
    required String value,
  }) = _SourceId;

  factory SourceId.fromJson(Map<String, dynamic> json) =>
      _$SourceIdFromJson(json);

  const SourceId._();

  static Result<SourceId> createFromRotationId(RotationId rotationId) {
    try {
      return Results.success(SourceId(value: rotationId.value));
    } on Exception catch (error) {
      return Results.failure(
        NotificationFailure('rotationIdからsourceIdへの変換に失敗しました: $error'),
      );
    }
  }
}
