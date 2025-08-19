import 'package:popcal/core/utils/results.dart';
import 'package:popcal/core/utils/time_utils.dart';

extension type RotationUpdatedAt._(DateTime value) {
  factory RotationUpdatedAt.now() =>
      RotationUpdatedAt._(TimeUtilsImpl.localTime());

  RotationUpdatedAt add(Duration duration) =>
      RotationUpdatedAt._(value.add(duration));

  static Result<RotationUpdatedAt> create(DateTime input) {
    return Results.success(RotationUpdatedAt._(input));
  }
}
