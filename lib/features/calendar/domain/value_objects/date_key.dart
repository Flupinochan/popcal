import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:popcal/core/utils/results.dart';

part 'date_key.freezed.dart';
part 'date_key.g.dart';

/// カレンダーの各日付のローテーション情報を取得するための各日付を示す「年月日」のKey
/// UIからはこのKeyを使用してバックエンドから返されたデータから情報を取得する
@freezed
sealed class DateKey with _$DateKey {
  const factory DateKey(DateTime value) = _DateKey;

  factory DateKey.fromJson(Map<String, dynamic> json) =>
      _$DateKeyFromJson(json);

  const DateKey._();

  static Result<DateKey> create(DateTime dateTime) {
    return Results.success(
      DateKey(DateTime(dateTime.year, dateTime.month, dateTime.day)),
    );
  }
}
