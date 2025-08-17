import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

part 'rotation_id.freezed.dart';
part 'rotation_id.g.dart';

@freezed
sealed class RotationId with _$RotationId {
  factory RotationId(String value) = _RotationId;

  factory RotationId.fromJson(Map<String, dynamic> json) =>
      _$RotationIdFromJson(json);

  const RotationId._();

  static Result<RotationId> create(String? input) {
    if (input == null || input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('ローテーションIDを入力してください'));
    }

    return Results.success(RotationId(input));
  }
}
