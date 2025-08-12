import 'package:freezed_annotation/freezed_annotation.dart';

// ignore: prefer-match-file-name
class DateKeyConverter implements JsonConverter<DateKey, String> {
  const DateKeyConverter();

  @override
  DateKey fromJson(String json) => DateKey.fromDateTime(DateTime.parse(json));

  @override
  String toJson(DateKey object) => object.value.toIso8601String();
}

/// カレンダー選択日とscheduleMapのKeyは年月日で判定すべき
extension type DateKey(DateTime value) {
  DateKey.fromDateTime(DateTime dateTime)
    : this(DateTime(dateTime.year, dateTime.month, dateTime.day));
}
