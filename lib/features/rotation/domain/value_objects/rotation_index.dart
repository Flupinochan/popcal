import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

part 'rotation_index.freezed.dart';

@freezed
sealed class RotationIndex with _$RotationIndex {
  const factory RotationIndex(int value) = _RotationIndex;
  const RotationIndex._();

  int getMemberIndex(int memberCount) {
    if (memberCount <= 0) {
      throw ArgumentError('メンバー数は1以上である必要があります');
    }
    return value % memberCount;
  }

  RotationIndex increment() {
    return RotationIndex(value + 1);
  }

  RotationIndex incrementBy(int count) {
    if (count < 0) {
      throw ArgumentError('インクリメント数は0以上である必要があります');
    }
    return RotationIndex(value + count);
  }

  @override
  String toString() => value.toString();

  static Result<RotationIndex> create(int? input) {
    if (input == null || input < 0) {
      return Results.failure(
        const ValidationFailure('ローテーションインデックスは0以上である必要があります'),
      );
    }

    return Results.success(RotationIndex(input));
  }
}
