import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

part 'user_id.freezed.dart';

@freezed
sealed class UserId with _$UserId {
  const factory UserId(String value) = _UserId;

  // freezedでjson serialize自動生成のために必要
  factory UserId.fromJson(String json) {
    final result = create(json);
    if (result.isFailure) {
      throw FormatException('Invalid UserId: ${result.displayText}');
    }
    return result.valueOrNull!;
  }
  const UserId._();

  String toJson() => value;

  @override
  String toString() => value;

  static Result<UserId> create(String? input) {
    if (input == null || input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('ユーザーIDを入力してください'));
    }

    return Results.success(UserId(input));
  }
}
