import 'package:popcal/core/utils/results.dart';

extension type RotationCreatedAt._(DateTime value) {
  RotationCreatedAt add(Duration duration) =>
      RotationCreatedAt._(value.add(duration));

  static Result<RotationCreatedAt> create(DateTime input) {
    return Result.ok(RotationCreatedAt._(input));
  }
}
