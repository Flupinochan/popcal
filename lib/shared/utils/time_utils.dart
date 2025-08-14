import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';

// flutterではオーバーロードやパッケージは存在しない
abstract class TimeUtils {
  // 年月日で比較
  // カレンダーの日付判定処理で、年月日までで比較する必要があるため
  bool isSameDateKeyWithNotificationDateTime(
    DateKey? a,
    NotificationDateTime? b,
  );
  bool isSameDay(DateTime? a, DateTime? b);
  // ローカル時刻取得用
  DateTime now();
}

class TimeUtilsImpl implements TimeUtils {
  @override
  bool isSameDateKeyWithNotificationDateTime(
    DateKey? a,
    NotificationDateTime? b,
  ) {
    if (a == null || b == null) return false;
    return a.value.year == b.value.year &&
        a.value.month == b.value.month &&
        a.value.day == b.value.day;
  }

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
