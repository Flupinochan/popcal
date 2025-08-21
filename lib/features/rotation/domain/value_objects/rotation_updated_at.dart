import 'package:popcal/core/utils/results.dart';

extension type RotationUpdatedAt._(DateTime value) {
  RotationUpdatedAt add(Duration duration) =>
      RotationUpdatedAt._(value.add(duration));

  static Result<RotationUpdatedAt> create(DateTime input) {
    return Result.ok(RotationUpdatedAt._(input));
  }
}
