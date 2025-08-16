import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

part 'rotation_name.freezed.dart';
part 'rotation_name.g.dart';

@freezed
sealed class RotationName with _$RotationName {
  const factory RotationName(
    String value,
  ) = _RotationName;

  factory RotationName.fromJson(Map<String, dynamic> json) =>
      _$RotationNameFromJson(json);

  const RotationName._();

  String getNotificationDescription() {
    return '$valueの通知';
  }

  String getNotificationTitle() {
    return value;
  }

  @override
  String toString() => value;

  static Result<RotationName> create(String? input) {
    if (input == null || input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('ローテーション名を入力してください'));
    }
    return Results.success(RotationName(input));
  }
}
