import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';

extension type SkipCount._(int value) {
  SkipCount({int skipCount = 1}) : this._(skipCount);

  Result<SkipCount> decrement() {
    // 0になる場合はSkipEventを削除する。decrementは不可
    if (value > 1) {
      return Results.failure(const ValidationFailure('1以上である必要があります'));
    }

    return Results.success(SkipCount._(value - 1));
  }

  Result<SkipCount> increment(RotationMemberNames input) {
    // length以上の場合は1巡するため、incrementは不可
    if (input.length <= value) {
      return Results.failure(
        const ValidationFailure('SkipCountはSkipEventの数以上である必要があります'),
      );
    }

    return Results.success(SkipCount._(value + 1));
  }
}
