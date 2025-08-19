import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

extension type RotationName._(String value) {
  static Result<RotationName> create(String input) {
    if (input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('バリデーションに失敗しました'));
    }

    return Results.success(RotationName._(input.trim()));
  }
}
