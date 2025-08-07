import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/themes/member_color.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/use_cases/get_calendar_schedule_use_case.dart';
import 'package:popcal/features/calendar/providers/calendar_loader.dart';
import 'package:popcal/features/notifications/utils/time_utils.dart';
import 'package:popcal/shared/widgets/custom_error_widget.dart';
import 'package:popcal/shared/widgets/custom_loading_widget.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/features/calendar/presentation/widgets/glass_chip.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';

class CalendarScreen extends HookConsumerWidget {
  final String rotationId;

  const CalendarScreen({super.key, required this.rotationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarDataAsync = ref.watch(
      calendarScheduleResponseProvider(rotationId),
    );
    return calendarDataAsync.when(
      data:
          (result) => result.when(
            success: (dto) => _buildCalendarScreen(context, dto),
            failure: (error) => customErrorWidget(context, error.message),
          ),
      loading: () => customLoadingWidget(context),
      error: (error, stack) => customErrorWidget(context, error.toString()),
    );
  }

  Widget _buildCalendarScreen(
    BuildContext context,
    CalendarScheduleResponse calendarDataDto,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final focusedDay = useState(DateTime.now().toLocal());
    final selectedDay = useState<DateTime?>(DateTime.now().toLocal());

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: calendarDataDto.rotationResponse.rotationName,
        leadingIcon: Icons.arrow_back_ios_new,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildCalendarContainer(
                        context,
                        calendarDataDto,
                        focusedDay,
                        selectedDay,
                      ),
                      const SizedBox(height: 16),
                      _buildSelectedDayInfo(
                        calendarDataDto,
                        selectedDay.value,
                        glassTheme,
                        textTheme,
                      ),
                      const SizedBox(height: 16),
                      _buildRotationInfo(context, calendarDataDto),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 1. カレンダー
  Widget _buildCalendarContainer(
    BuildContext context,
    CalendarScheduleResponse calendarDataDto,
    ValueNotifier<DateTime> focusedDay,
    ValueNotifier<DateTime?> selectedDay,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return GlassWrapper(
      child: TableCalendar<String>(
        firstDay: DateTime.now().toLocal().subtract(
          const Duration(days: GetCalendarScheduleUseCase.pastDays),
        ),
        lastDay: DateTime.now().toLocal().add(
          const Duration(days: GetCalendarScheduleUseCase.futureDays),
        ),
        focusedDay: focusedDay.value,
        selectedDayPredicate:
            (day) => TimeUtils.isSameDay(selectedDay.value, day),
        calendarFormat: CalendarFormat.month,
        startingDayOfWeek: StartingDayOfWeek.monday,
        sixWeekMonthsEnforced: true,
        onDaySelected: (selected, focused) {
          selectedDay.value = selected;
          focusedDay.value = focused;
        },
        onPageChanged: (focused) {
          focusedDay.value = focused;
        },
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
          headerPadding: EdgeInsets.only(left: 0, right: 0, top: 16, bottom: 6),
        ),
        // 月火水木金土日の高さ および スタイル
        daysOfWeekHeight: 40,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: textTheme.labelLarge!,
          weekendStyle: textTheme.labelLarge!,
          dowTextFormatter: (date, locale) {
            const weekdays = ['月', '火', '水', '木', '金', '土', '日'];
            return weekdays[(date.weekday - 1) % 7];
          },
        ),
        // 各日付のスタイル
        calendarStyle: CalendarStyle(outsideDaysVisible: false),
        calendarBuilders: CalendarBuilders(
          // 通常の日付
          defaultBuilder: (context, day, focusedDay) {
            return _buildCalendarCell(
              context,
              calendarDataDto,
              day,
              false,
              false,
            );
          },
          // 今日の日付
          todayBuilder: (context, day, focusedDay) {
            return _buildCalendarCell(
              context,
              calendarDataDto,
              day,
              true,
              false,
            );
          },
          // 選択された日付
          selectedBuilder: (context, day, focusedDay) {
            return _buildCalendarCell(
              context,
              calendarDataDto,
              day,
              false,
              true,
            );
          },
        ),
      ),
    );
  }

  Widget _buildCalendarCell(
    BuildContext context,
    CalendarScheduleResponse calendarDataDto,
    DateTime day,
    bool isToday,
    bool isSelected,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    final dayInfo = calendarDataDto.getDayInfo(day);
    final memberName = dayInfo.memberName;
    final isRotationDay = dayInfo.isRotationDay;

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color:
                  isSelected
                      ? Colors.blue.withValues(alpha: 0.4)
                      : isToday
                      ? Colors.amber.withValues(alpha: 0.3)
                      : isRotationDay
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${day.day}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          isRotationDay && memberName != null
              ? Text(
                memberName,
                style: textTheme.labelMedium!.copyWith(
                  color:
                      dayInfo.memberColorIndex != null
                          ? memberColors[dayInfo.memberColorIndex! %
                              memberColors.length]
                          : Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
              : const SizedBox(),
        ],
      ),
    );
  }

  // 2. 選択した曜日のローテーションメンバー名表示
  Widget _buildSelectedDayInfo(
    CalendarScheduleResponse calendarDataDto,
    DateTime? selectedDay,
    GlassTheme glass,
    TextTheme textTheme,
  ) {
    if (selectedDay == null) {
      return const SizedBox.shrink();
    }

    final dayInfo = calendarDataDto.getDayInfo(selectedDay);
    final memberName = dayInfo.memberName;
    final isRotationDay = dayInfo.isRotationDay;

    return GlassWrapper(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 日付アイコン
            GlassWrapper(
              width: 60,
              height: 60,
              showBorder: false,
              gradient: glass.backgroundGradientStrong,
              child: Center(
                child: Text(
                  '${selectedDay.month}/${selectedDay.day}',
                  style: textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      // 曜日
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        child: Text(
                          Weekday.fromDateTime(selectedDay).displayName,
                          style: textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // 担当日/対象外
                      GlassChip(
                        text: dayInfo.displayText,
                        gradient:
                            isRotationDay
                                ? glass.successGradient
                                : glass.backgroundGradientStrong,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      // Icon
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        child: Icon(
                          isRotationDay ? Icons.person : Icons.person_off,
                          color:
                              isRotationDay
                                  ? glass.surfaceColor
                                  : glass.surfaceColor.withValues(alpha: 0.6),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // メンバー名
                      Text(
                        memberName ?? 'ローテーション対象外',
                        style: textTheme.titleMedium!.copyWith(
                          color:
                              isRotationDay
                                  ? glass.surfaceColor
                                  : glass.surfaceColor.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. ローテーション情報
  Widget _buildRotationInfo(
    BuildContext context,
    CalendarScheduleResponse calendarDataDto,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return GlassWrapper(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ローテーション情報
            _rotationInfoItem(
              context,
              'ローテーション情報',
              Icons.info_outline,
              iconSize: 20,
              textStyle: textTheme.titleMedium,
            ),
            const SizedBox(height: 14),
            // メンバー
            _rotationInfoItem(
              context,
              'メンバー: ${calendarDataDto.rotationResponse.rotationMembers.join(', ')}',
              Icons.group,
            ),
            const SizedBox(height: 12),
            // 曜日
            _rotationInfoItem(
              context,
              '曜日: ${calendarDataDto.rotationResponse.rotationDays.map((w) => w.displayName).join(', ')}',
              Icons.calendar_today,
            ),
            const SizedBox(height: 12),
            // 通知時刻
            _rotationInfoItem(
              context,
              '時刻: ${calendarDataDto.rotationResponse.notificationTime.hour.toString().padLeft(2, '0')}:${calendarDataDto.rotationResponse.notificationTime.minute.toString().padLeft(2, '0')}',
              Icons.access_time,
            ),
          ],
        ),
      ),
    );
  }

  Widget _rotationInfoItem(
    BuildContext context,
    String infoText,
    IconData iconData, {
    double iconSize = 18,
    TextStyle? textStyle,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    final effectiveTextStyle = textStyle ?? textTheme.titleSmall;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(iconData, color: glassTheme.surfaceColor, size: iconSize),
        const SizedBox(width: 8),
        Text(
          infoText,
          style: effectiveTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
