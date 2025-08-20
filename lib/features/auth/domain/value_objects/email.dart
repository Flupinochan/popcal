import 'package:popcal/core/utils/exceptions/validation_exception.dart';
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
      return const Result.error(ValidationException('メールアドレスを入力してください'));
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(input)) {
      return const Result.error(ValidationException('メールアドレスの形式にしてください'));
    }

    return Result.ok(Email._(input.trim()));
  }
}
