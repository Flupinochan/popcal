import 'package:freezed_annotation/freezed_annotation.dart';

extension type RotationName(String value) {}

class RotationNameConverter implements JsonConverter<RotationName, String> {
  const RotationNameConverter();

  @override
  RotationName fromJson(String json) => RotationName(json);

  @override
  String toJson(RotationName object) => object.value;
}
