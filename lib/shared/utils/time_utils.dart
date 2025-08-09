abstract class TimeUtils {
  DateTime now();
}

class TimeUtilsImpl implements TimeUtils {
  /// 日付が同じかどうかを判定
  /// 曜日ごとのローテーションであり、for文で現在時刻+1日してループ計算するため
  /// 日付までで比較すべき
  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // dtoなどDIできない場合に利用
  static DateTime getLocalDateTime() {
    return DateTime.now().toLocal();
  }

  // DI用 テストでmockするため
  @override
  DateTime now() {
    return DateTime.now().toLocal();
  }
}
