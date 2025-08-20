import 'package:popcal/core/utils/exceptions/validation_exception.dart';
import 'package:popcal/core/utils/results.dart';

extension type RotationId._(String value) {
  static Result<RotationId> create(String input) {
    if (input.trim().isEmpty) {
      return const Result.error(ValidationException('バリデーションに失敗しました'));
    }
    return Result.ok(RotationId._(input.trim()));
  }
}
