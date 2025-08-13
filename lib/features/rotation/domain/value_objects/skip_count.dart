import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/rotation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';

part 'skip_count.freezed.dart';

@freezed
sealed class SkipCount with _$SkipCount {
  const factory SkipCount({
    required int skipCount,
  }) = _SkipCount;
  const SkipCount._();

  SkipCount decrement() {
    // 0になる場合はSkipEventを削除する。decrementは不可
    if (skipCount == 1) {
      throw Exception('SkipCountは1以上である必要があります');
    }
    return SkipCount(skipCount: skipCount - 1);
  }

  SkipCount increment(List<SkipEvent> skipEvents) {
    // length以上の場合は1巡するため、incrementは不可
    if (skipEvents.length <= skipCount) {
      throw Exception('SkipCountはSkipEventの数以上である必要があります');
    }
    return SkipCount(skipCount: skipCount + 1);
  }

  static Result<SkipCount> create(int? input) {
    if (input == null || input < 1) {
      return Results.failure(const RotationFailure('SkipCountは1以上である必要があります'));
    }
    return Results.success(SkipCount(skipCount: input));
  }
}
