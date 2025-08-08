import 'package:freezed_annotation/freezed_annotation.dart';

extension type const RotationMemberName(String value) {
  // nullの代わりに指定する文字列
  static const RotationMemberName notApplicable = RotationMemberName(
    'ローテーション対象外',
  );
}

class RotationMemberNameConverter
    implements JsonConverter<RotationMemberName, String> {
  const RotationMemberNameConverter();

  @override
  RotationMemberName fromJson(String json) => RotationMemberName(json);

  @override
  String toJson(RotationMemberName object) => object.value;
}
