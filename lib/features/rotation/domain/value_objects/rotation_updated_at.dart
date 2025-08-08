import 'package:freezed_annotation/freezed_annotation.dart';

extension type RotationUpdatedAt(DateTime value) {}

class RotationUpdatedAtConverter
    implements JsonConverter<RotationUpdatedAt, String> {
  const RotationUpdatedAtConverter();

  @override
  RotationUpdatedAt fromJson(String json) =>
      RotationUpdatedAt(DateTime.parse(json));

  @override
  String toJson(RotationUpdatedAt object) => object.value.toIso8601String();
}
