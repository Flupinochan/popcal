import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/presentation/widgets/calendar_cell.dart';
import 'package:popcal/features/calendar/use_cases/get_calendar_schedule_use_case.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarContainer extends ConsumerWidget {
  const CalendarContainer({
    required this.calendarScheduleResponse,
    required this.focusedDay,
    required this.selectedDay,
    required this.now,
    super.key,
  });

  final CalendarScheduleResponse calendarScheduleResponse;
  final ValueNotifier<DateTime> focusedDay;
  final ValueNotifier<DateTime?> selectedDay;
  final DateTime now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final timeUtils = ref.watch(timeUtilsProvider);

    // TableCalendarを利用したカレンダー表示
    return GlassWrapper(
      child: TableCalendar<String>(
        currentDay: timeUtils.now(),
        firstDay: now.subtract(
          const Duration(days: GetCalendarScheduleUseCase.pastDays),
        ),
        lastDay: now.add(
          const Duration(days: GetCalendarScheduleUseCase.futureDays),
        ),
        focusedDay: focusedDay.value,
        selectedDayPredicate:
            (day) => timeUtils.isSameDay(selectedDay.value, day),
        startingDayOfWeek: StartingDayOfWeek.monday,
        sixWeekMonthsEnforced: true,
        onDaySelected: _onDaySelected,
        onPageChanged: _onPageChanged,
        // <     July 2025     > のスタイル
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: textTheme.titleLarge!,
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: glassTheme.surfaceColor,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: glassTheme.surfaceColor,
          ),
          headerPadding: const EdgeInsets.only(top: 16, bottom: 6),
        ),
        // 月火水木金土日の高さ および スタイル
        daysOfWeekHeight: 40,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: textTheme.labelLarge!,
          weekendStyle: textTheme.labelLarge!,
          dowTextFormatter: _formatDayOfWeek,
        ),
        // 各日付のスタイル
        calendarStyle: const CalendarStyle(outsideDaysVisible: false),
        calendarBuilders: CalendarBuilders(
          // 月火水木金土日
          dowBuilder: (context, day) {
            const weekdays = ['月', '火', '水', '木', '金', '土', '日'];
            final text = weekdays[day.weekday - 1];
            if (day.weekday == DateTime.sunday) {
              return Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.redAccent.withValues(alpha: 0.8),
                  ),
                ),
              );
            } else if (day.weekday == DateTime.saturday) {
              return Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.blue.withValues(alpha: 0.9)),
                ),
              );
            }
            return Center(
              child: Text(
                text,
                style: TextStyle(color: glassTheme.surfaceColor),
              ),
            );
          },
          // 通常の日付
          defaultBuilder: (context, day, focusedDay) {
            return CalendarCell(
              calendarDataDto: calendarScheduleResponse,
              day: day,
              isToday: false,
              isSelected: false,
            );
          },
          // 今日の日付
          todayBuilder: (context, day, focusedDay) {
            return CalendarCell(
              calendarDataDto: calendarScheduleResponse,
              day: day,
              isToday: true,
              isSelected: false,
            );
          },
          // 選択された日付
          selectedBuilder: (context, day, focusedDay) {
            return CalendarCell(
              calendarDataDto: calendarScheduleResponse,
              day: day,
              isToday: false,
              isSelected: true,
            );
          },
        ),
      ),
    );
  }

  // ignore: avoid-dynamic
  String _formatDayOfWeek(DateTime date, dynamic locale) {
    const weekdays = ['月', '火', '水', '木', '金', '土', '日'];
    return weekdays[(date.weekday - 1) % 7];
  }

  void _onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  void _onPageChanged(DateTime focused) {
    focusedDay.value = focused;
  }
}
