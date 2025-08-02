/// カレンダーの各日付表示用データ
class CalendarDay {
  final DateTime date;
  final String? memberName;
  final bool isRotationDay;

  const CalendarDay({
    required this.date,
    required this.memberName,
    required this.isRotationDay,
  });

  String get displayText => isRotationDay ? "担当日" : "対象外";
}
