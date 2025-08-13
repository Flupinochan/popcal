import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/notifications/domain/value_objects/notification_datetime.dart';

// flutterではオーバーロードやパッケージは存在しない
abstract class TimeUtils {
  // 以下3つの処理はValueObjectに移動すべき
  bool isSameDateKey(DateKey? a, DateKey? b);
  bool isSameDateKeyWithNotificationDateTime(
    DateKey? a,
    NotificationDateTime? b,
  );
  bool isSameDay(DateTime? a, DateTime? b);

  DateTime now();
}

class TimeUtilsImpl implements TimeUtils {
  @override
  bool isSameDateKey(DateKey? a, DateKey? b) {
    if (a == null || b == null) return false;
    return a.value.year == b.value.year &&
        a.value.month == b.value.month &&
        a.value.day == b.value.day;
  }

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
