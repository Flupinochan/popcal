import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

class RotationMemberNameConverter
    implements JsonConverter<RotationMemberName, String> {
  const RotationMemberNameConverter();

  @override
  RotationMemberName fromJson(String json) => RotationMemberName(json);

  @override
  String toJson(RotationMemberName object) => object.value;
}

extension type const RotationMemberName(String value) {
  // nullの代わりに指定する文字列
  static const RotationMemberName notApplicable = RotationMemberName(
    'ローテーション対象外',
  );

  String getNotificationContent() {
    return '今日は$valueの番です';
  }

  static Result<RotationMemberName> create(String? input) {
    if (input == null || input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('メンバーを1つ以上追加してください'));
    }
    return Results.success(RotationMemberName(input));
  }
}
