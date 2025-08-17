import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

part 'user_id.freezed.dart';
part 'user_id.g.dart';

@freezed
sealed class UserId with _$UserId {
  const factory UserId(String value) = _UserId;

  factory UserId.fromJson(Map<String, dynamic> json) => _$UserIdFromJson(json);

  const UserId._();

  static Result<UserId> create(String? input) {
    if (input == null || input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('ユーザーIDを入力してください'));
    }

    return Results.success(UserId(input));
  }
}
