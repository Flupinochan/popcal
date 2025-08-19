import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

extension type RotationId._(String value) {
  static Result<RotationId> create(String input) {
    if (input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('バリデーションに失敗しました'));
    }
    return Results.success(RotationId._(input.trim()));
  }
}
