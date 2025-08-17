import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';

class CalendarCell extends StatelessWidget {
  const CalendarCell({
    required this.calendarDataDto,
    required this.day,
    required this.isToday,
    required this.isSelected,
    super.key,
  });

  final CalendarScheduleResponse calendarDataDto;
  final DateTime day;
  final bool isToday;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    final dayInfo = calendarDataDto.getDayInfo(day);
    final memberName = dayInfo.memberName;
    final isValidRotationDay = dayInfo.isValidRotationDay;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: glassTheme.borderColor, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(),
          // カレンダーの日付
          Container(
            width: 26,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _getBackgroundColor(dayInfo),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // ローテーション担当者をカレンダー日付に表示
          if (isValidRotationDay)
            Text(
              memberName,
              style: textTheme.labelMedium!.copyWith(
                color: dayInfo.memberColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }

  Color _getBackgroundColor(ScheduleDayResponse dayInfo) {
    if (isSelected) return Colors.blue.withValues(alpha: 0.4);
    if (isToday) return Colors.amber.withValues(alpha: 0.3);
    return dayInfo.scheduleDayType.bkColor;
  }
}
