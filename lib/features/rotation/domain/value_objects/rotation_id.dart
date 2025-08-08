import 'package:freezed_annotation/freezed_annotation.dart';

extension type RotationId(String value) {}

class RotationIdConverter implements JsonConverter<RotationId, String> {
  const RotationIdConverter();

  @override
  RotationId fromJson(String json) => RotationId(json);

  @override
  String toJson(RotationId object) => object.value;
}
