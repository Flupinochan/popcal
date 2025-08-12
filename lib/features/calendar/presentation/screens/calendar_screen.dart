import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/presentation/widgets/calendar_cell.dart';
import 'package:popcal/features/calendar/presentation/widgets/glass_chip.dart';
import 'package:popcal/features/calendar/presentation/widgets/info_row_item.dart';
import 'package:popcal/features/calendar/providers/calendar_loader.dart';
import 'package:popcal/features/calendar/use_cases/get_calendar_schedule_use_case.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/screens/custom_error_screen.dart';
import 'package:popcal/shared/screens/custom_loading_screen.dart';
import 'package:popcal/shared/utils/time_utils.dart';
import 'package:popcal/shared/widgets/glass_app_bar/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends HookConsumerWidget {
  const CalendarScreen({required this.rotationId, super.key});
  final RotationId rotationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeUtils = ref.watch(timeUtilsProvider);
    final now = timeUtils.now();
    final calendarDataAsync = ref.watch(
      calendarScheduleResponseProvider(rotationId),
    );
    return calendarDataAsync.when(
      data:
          (result) => result.when(
            success:
                (dto) => _buildCalendarScreen(context, dto, now, timeUtils),
            failure: (error) => CustomErrorScreen(message: error.message),
          ),
      loading: CustomLoadingScreen.new,
      error: (error, stack) => const CustomErrorScreen(),
    );
  }

  // 1. カレンダー
  Widget _buildCalendarContainer(
    BuildContext context,
    CalendarScheduleResponse calendarDataDto,
    ValueNotifier<DateTime> focusedDay,
    ValueNotifier<DateTime?> selectedDay,
    DateTime now,
    TimeUtils timeUtils,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return GlassWrapper(
      child: TableCalendar<String>(
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
          headerPadding: const EdgeInsets.only(top: 16, bottom: 6),
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
        calendarStyle: const CalendarStyle(outsideDaysVisible: false),
        calendarBuilders: CalendarBuilders(
          // 通常の日付
          defaultBuilder: (context, day, focusedDay) {
            return CalendarCell(
              calendarDataDto: calendarDataDto,
              day: day,
              isToday: false,
              isSelected: false,
            );
          },
          // 今日の日付
          todayBuilder: (context, day, focusedDay) {
            return CalendarCell(
              calendarDataDto: calendarDataDto,
              day: day,
              isToday: true,
              isSelected: false,
            );
          },
          // 選択された日付
          selectedBuilder: (context, day, focusedDay) {
            return CalendarCell(
              calendarDataDto: calendarDataDto,
              day: day,
              isToday: false,
              isSelected: true,
            );
          },
        ),
      ),
    );
  }

  Widget _buildCalendarScreen(
    BuildContext context,
    CalendarScheduleResponse calendarDataDto,
    DateTime now,
    TimeUtils timeUtils,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final focusedDay = useState(now);
    final selectedDay = useState<DateTime?>(now);

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: calendarDataDto.rotationResponse.rotationName.value,
        leadingIcon: Icons.arrow_back_ios_new,
        onLeadingPressed: () => context.pop(),
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
                    spacing: 16,
                    children: [
                      _buildCalendarContainer(
                        context,
                        calendarDataDto,
                        focusedDay,
                        selectedDay,
                        now,
                        timeUtils,
                      ),
                      _buildSelectedDayInfo(
                        calendarDataDto,
                        selectedDay.value,
                        glassTheme,
                        textTheme,
                      ),
                      _buildRotationInfo(context, calendarDataDto),
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
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ローテーション情報
            InfoRowItem(
              infoText: 'ローテーション情報',
              iconData: Icons.info_outline,
              iconSize: 20,
              textStyle: textTheme.titleMedium,
            ),
            // メンバー
            InfoRowItem(
              infoText:
                  'メンバー: ${calendarDataDto.rotationResponse.rotationMembers.join(', ')}',
              iconData: Icons.group,
            ),
            // 曜日
            InfoRowItem(
              infoText:
                  '曜日: ${calendarDataDto.rotationResponse.rotationDays.map((w) => w.displayName).join(', ')}',
              iconData: Icons.calendar_today,
            ),
            // 通知時刻
            InfoRowItem(
              infoText:
                  '時刻: ${calendarDataDto.rotationResponse.notificationTime.display24hour}',
              iconData: Icons.access_time,
            ),
          ],
        ),
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
    final iconColor =
        isRotationDay
            ? glass.surfaceColor
            : glass.surfaceColor.withValues(alpha: 0.6);

    return GlassWrapper(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 16,
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
            Expanded(
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    spacing: 8,
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
                  Row(
                    spacing: 10,
                    children: [
                      // Icon
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        child: Icon(
                          isRotationDay ? Icons.person : Icons.person_off,
                          color: iconColor,
                          size: 20,
                        ),
                      ),
                      // メンバー名
                      Text(
                        memberName.value,
                        style: textTheme.titleMedium!.copyWith(
                          color: iconColor,
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
}
