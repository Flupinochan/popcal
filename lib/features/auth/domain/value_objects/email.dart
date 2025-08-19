import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

// ._にすることでプライベート化
// createメソッドで作成する
extension type Email._(String value) {
  String get domain => value.split('@')[1];
  String get localPart => value.split('@').first;

  // nullチェックはUIで行うため不要
  // extention typeは値が1つのためrequiredは不要
  static Result<Email> create(String input) {
    if (input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('メールアドレスを入力してください'));
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(input)) {
      return Results.failure(const ValidationFailure('メールアドレスの形式にしてください'));
    }

    return Results.success(Email._(input.trim()));
  }
}
