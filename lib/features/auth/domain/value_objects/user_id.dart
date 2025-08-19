import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

extension type UserId._(String value) {
  static Result<UserId> create(String input) {
    if (input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('ユーザーIDを入力してください'));
    }

    return Results.success(UserId._(input.trim()));
  }

  static UserId empty() => UserId._('');
}
