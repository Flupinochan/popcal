import 'package:freezed_annotation/freezed_annotation.dart';

extension type NotificationDate(DateTime value) {
  bool isBefore(DateTime other) {
    return value.isBefore(other);
  }
}

class NotificationDateConverter
    implements JsonConverter<NotificationDate, String> {
  const NotificationDateConverter();

  @override
  NotificationDate fromJson(String json) =>
      NotificationDate(DateTime.parse(json));

  @override
  String toJson(NotificationDate object) => object.value.toIso8601String();
}
