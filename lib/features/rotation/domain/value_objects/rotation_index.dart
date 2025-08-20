import 'package:popcal/core/utils/exceptions/validation_exception.dart';
import 'package:popcal/core/utils/results.dart';

extension type RotationIndex._(int value) {
  // 初期化用
  RotationIndex() : this._(0);

  int getMemberIndex(int memberCount) {
    return value % memberCount;
  }

  RotationIndex increment() {
    return RotationIndex._(value + 1);
  }

  Result<RotationIndex> incrementBy(int count) {
    if (count < 1) {
      return const Result.error(
        ValidationException('インクリメント数は1以上である必要があります'),
      );
    }

    return Result.ok(RotationIndex._(value + count));
  }

  static Result<RotationIndex> createFromInt(int input) {
    if (input < 0) {
      const Result<RotationIndex>.error(
        ValidationException('値は0以上である必要があります'),
      );
    }

    return Result.ok(RotationIndex._(input));
  }
}
