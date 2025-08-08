import 'package:freezed_annotation/freezed_annotation.dart';

extension type RotationMemberName(String value) {}

class RotationMemberNameConverter
    implements JsonConverter<RotationMemberName, String> {
  const RotationMemberNameConverter();

  @override
  RotationMemberName fromJson(String json) => RotationMemberName(json);

  @override
  String toJson(RotationMemberName object) => object.value;
}
