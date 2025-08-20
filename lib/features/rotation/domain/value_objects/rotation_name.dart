import 'package:popcal/core/utils/exceptions/validation_exception.dart';
import 'package:popcal/core/utils/results.dart';

extension type RotationName._(String value) {
  static Result<RotationName> create(String input) {
    if (input.trim().isEmpty) {
      return const Result.error(ValidationException('バリデーションに失敗しました'));
    }

    return Result.ok(RotationName._(input.trim()));
  }
}
