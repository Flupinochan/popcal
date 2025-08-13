import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/rotation_failure.dart';
import 'package:popcal/core/utils/results.dart';

part 'skip_count.freezed.dart';

@freezed
sealed class SkipCount with _$SkipCount {
  const factory SkipCount({
    required int skipCount,
  }) = _SkipCount;
  const SkipCount._();

  SkipCount decrement() {
    if (skipCount == 1) {
      return SkipCount(skipCount: skipCount);
    }
    return SkipCount(skipCount: skipCount - 1);
  }

  SkipCount increment() {
    return SkipCount(skipCount: skipCount + 1);
  }

  static Result<SkipCount> create(int? input) {
    if (input == null || input < 1) {
      return Results.failure(const RotationFailure('SkipCountは1以上である必要があります'));
    }
    return Results.success(SkipCount(skipCount: input));
  }
}
