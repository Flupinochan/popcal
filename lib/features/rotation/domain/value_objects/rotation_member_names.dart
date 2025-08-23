import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/exceptions/validation_exception.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';

part 'rotation_member_names.freezed.dart';

@freezed
sealed class RotationMemberNames with _$RotationMemberNames {
  // List<RotationMemberName> への移行
  const factory RotationMemberNames(List<String> value) = _RotationMemberNames;

  const RotationMemberNames._();

  int get length => value.length;
  Result<RotationMemberName> memberAt(int position) {
    final result = RotationMemberName.create(value[position]);
    if (result.isError) {
      Result<RotationMemberName>.error(result.error);
    }

    return Result.ok(result.value);
  }

  static Result<RotationMemberNames> create(List<String>? input) {
    if (input == null || input.isEmpty || input.length < 2) {
      return const Result.error(ValidationException('メンバーを2つ以上追加してください'));
    }

    return Result.ok(RotationMemberNames(input));
  }

  // ignore: avoid-dynamic
  static Result<RotationMemberNames> createFromDynamic(List<dynamic>? input) {
    if (input == null || input.isEmpty || input.length < 2) {
      return const Result.error(ValidationException('メンバーを2つ以上追加してください'));
    }

    // dynamicをStringに変換
    final stringList =
        input
            .where((item) => item != null && item.toString().trim().isNotEmpty)
            .map((item) => item.toString())
            .toList();

    if (stringList.isEmpty) {
      return const Result.error(ValidationException('有効なメンバーが見つかりませんでした'));
    }

    return Result.ok(RotationMemberNames(stringList));
  }
}
