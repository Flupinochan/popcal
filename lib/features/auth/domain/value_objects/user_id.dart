import 'package:popcal/core/utils/exceptions/validation_exception.dart';
import 'package:popcal/core/utils/results.dart';

extension type UserId._(String value) {
  static Result<UserId> create(String input) {
    if (input.trim().isEmpty) {
      return const Result.error(ValidationException('ユーザーIDを入力してください'));
    }

    return Result.ok(UserId._(input.trim()));
  }

  static UserId empty() => UserId._('');
}
