// flutterではオーバーロードやパッケージは存在しない
abstract class TimeUtils {
  // 年月日で比較
  // カレンダーの日付判定処理で、年月日までで比較する必要があるため
  bool isSameDay(DateTime? a, DateTime? b);
  // ローカル時刻取得用
  DateTime now();
}

class TimeUtilsImpl implements TimeUtils {
  @override
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  DateTime now() {
    return DateTime.now().toLocal();
  }

  static DateTime localTime() {
    return DateTime.now().toLocal();
  }
}
