import 'package:freezed_annotation/freezed_annotation.dart';

class DateKeyConverter implements JsonConverter<DateKey, String> {
  const DateKeyConverter();

  @override
  DateKey fromJson(String json) => DateKey.fromDateTime(DateTime.parse(json));

  @override
  String toJson(DateKey object) => object.value.toIso8601String();
}

/// カレンダーの各日付のローテーション情報を取得するための各日付を示す「年月日」のKey
/// UIからはこのKeyを使用してバックエンドから返されたデータから情報を取得する
extension type DateKey(DateTime value) {
  DateKey.fromDateTime(DateTime dateTime)
    : this(DateTime(dateTime.year, dateTime.month, dateTime.day));
}
