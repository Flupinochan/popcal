import 'package:popcal/core/utils/exceptions/validation_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';

extension type SkipCount._(int value) {
  SkipCount({int skipCount = 1}) : this._(skipCount);

  bool canDecrement() {
    // 2以上であること
    // 1の場合は0になるためDecrementは不可、SkipEventを削除する
    return value > 1;
  }

  bool canDecrementOrDelete() {
    return value > 0;
  }

  bool canIncrement(RotationMemberNames input) {
    // 1巡以上のincrementは不可
    // 人数が3人の場合は2回までのため-1
    return input.length - 1 > value;
  }

  Result<SkipCount> decrement() {
    if (!canDecrement()) {
      return const Result.error(ValidationException('1以上である必要があります'));
    }

    return Result.ok(SkipCount._(value - 1));
  }

  Result<SkipCount> increment(RotationMemberNames input) {
    if (!canIncrement(input)) {
      return const Result.error(
        ValidationException('SkipCountはSkipEventの数以上である必要があります'),
      );
    }

    return Result.ok(SkipCount._(value + 1));
  }
}
