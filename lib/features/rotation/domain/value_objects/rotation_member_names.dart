import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';

part 'rotation_member_names.freezed.dart';

@freezed
sealed class RotationMemberNames with _$RotationMemberNames {
  const factory RotationMemberNames(List<String> value) = _RotationMemberNames;

  const RotationMemberNames._();

  int get length => value.length;
  Result<RotationMemberName> memberAt(int position) {
    final result = RotationMemberName.create(value[position]);
    if (result.isFailure) {
      Results.failure<RotationMemberName>(
        ValidationFailure(result.displayText),
      );
    }

    return Results.success(result.valueOrNull!);
  }

  static Result<RotationMemberNames> create(List<String>? input) {
    if (input == null || input.isEmpty || input.length < 2) {
      return Results.failure(const ValidationFailure('メンバーを2つ以上追加してください'));
    }

    return Results.success(RotationMemberNames(input));
  }

  // ignore: avoid-dynamic
  static Result<RotationMemberNames> createFromDynamic(List<dynamic>? input) {
    if (input == null || input.isEmpty || input.length < 2) {
      return Results.failure(const ValidationFailure('メンバーを2つ以上追加してください'));
    }

    // dynamicをStringに変換
    final stringList =
        input
            .where((item) => item != null && item.toString().trim().isNotEmpty)
            .map((item) => item.toString())
            .toList();

    if (stringList.isEmpty) {
      return Results.failure(const ValidationFailure('有効なメンバーが見つかりませんでした'));
    }

    return Results.success(RotationMemberNames(stringList));
  }
}
