import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';

part 'rotation_index.freezed.dart';

@freezed
sealed class RotationIndex with _$RotationIndex {
  const factory RotationIndex(int value) = _RotationIndex;
  const RotationIndex._();

  static Result<RotationIndex> create(int? input) {
    if (input == null || input < 0) {
      return Results.failure(ValidationFailure('ローテーションインデックスは0以上である必要があります'));
    }

    return Results.success(RotationIndex(input));
  }

  @override
  String toString() => value.toString();
}
