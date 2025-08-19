import 'package:popcal/core/utils/results.dart';

/// カレンダーの各日付のローテーション情報を取得するための各日付を示す「年月日」のKey
/// UIからはこのKeyを使用してバックエンドから返されたデータから情報を取得する
extension type DateKey._(DateTime value) {
  static Result<DateKey> create(DateTime input) {
    return Results.success(
      DateKey._(DateTime(input.year, input.month, input.day)),
    );
  }
}
