import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/core/utils/failures.dart';

part 'user_id.freezed.dart';

@freezed
sealed class UserId with _$UserId {
  const factory UserId(String value) = _UserId;
  const UserId._();

  static Result<UserId> create(String? input) {
    if (input == null || input.trim().isEmpty) {
      return Results.failure(ValidationFailure('ユーザーIDを入力してください'));
    }

    return Results.success(UserId(input));
  }

  // freezedでjson serialize自動生成のために必要
  factory UserId.fromJson(String json) {
    final result = create(json);
    if (result.isFailure) {
      throw FormatException('Invalid UserId: ${result.displayText}');
    }
    return result.valueOrNull!;
  }

  String toJson() => value;

  @override
  String toString() => value;
}
