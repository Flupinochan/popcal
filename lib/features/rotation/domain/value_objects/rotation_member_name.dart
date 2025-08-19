import 'package:popcal/core/utils/failures/validation_failure.dart';
import 'package:popcal/core/utils/results.dart';

extension type RotationMemberName._(String value) {
  static const String notApplicableText = 'ローテーション対象外';
  static final RotationMemberName notApplicable = RotationMemberName._(
    'ローテーション対象外',
  );

  String getNotificationContent() {
    return '今日は$valueの番です';
  }

  static Result<RotationMemberName> create(String input) {
    if (input.trim().isEmpty) {
      return Results.failure(const ValidationFailure('バリデーションに失敗しました'));
    }
    return Results.success(RotationMemberName._(input.trim()));
  }
}
