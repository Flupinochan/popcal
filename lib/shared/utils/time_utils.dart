abstract class TimeUtils {
  bool isSameDay(DateTime? a, DateTime? b);
  DateTime now();
}

class TimeUtilsImpl implements TimeUtils {
  /// 日付が同じかどうかを判定
  /// 曜日ごとのローテーションであり、for文で現在時刻+1日してループ計算するため
  /// 日付までで比較すべき
  @override
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  DateTime now() {
    return DateTime.now().toLocal();
  }
}
