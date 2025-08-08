import 'package:freezed_annotation/freezed_annotation.dart';

extension type RotationCreatedAt(DateTime value) {}

class RotationCreatedAtConverter
    implements JsonConverter<RotationCreatedAt, String> {
  const RotationCreatedAtConverter();

  @override
  RotationCreatedAt fromJson(String json) =>
      RotationCreatedAt(DateTime.parse(json));

  @override
  String toJson(RotationCreatedAt object) => object.value.toIso8601String();
}
