import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';

part 'rotation_member_names.freezed.dart';
part 'rotation_member_names.g.dart';

@freezed
sealed class RotationMemberNames with _$RotationMemberNames {
  const factory RotationMemberNames(List<String> value) = _RotationMemberNames;

  factory RotationMemberNames.fromJson(Map<String, dynamic> json) =>
      _$RotationMemberNamesFromJson(json);

  const RotationMemberNames._();

  int get length => value.length;
  RotationMemberName memberAt(int position) =>
      RotationMemberName(value[position]);

  static Result<RotationMemberNames> create(List<String>? input) {
    if (input == null || input.isEmpty) {
      return Results.failure(const ValidationFailure('メンバーを1つ以上追加してください'));
    }

    return Results.success(RotationMemberNames(input));
  }

  // ignore: avoid-dynamic
  static Result<RotationMemberNames> createFromDynamic(List<dynamic>? input) {
    if (input == null || input.isEmpty) {
      return Results.failure(const ValidationFailure('メンバーを1つ以上追加してください'));
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
