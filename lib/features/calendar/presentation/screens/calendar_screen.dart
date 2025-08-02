import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/themes/member_color.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_data_dto.dart';
import 'package:popcal/features/calendar/presentation/providers/calendar_screen_data.dart';
import 'package:popcal/shared/widgets/custom_error_widget.dart';
import 'package:popcal/shared/widgets/custom_loading_widget.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/features/calendar/presentation/widgets/glass_chip.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';
import 'package:popcal/features/notifications/domain/entities/notification_detail.dart';

class CalendarScreen extends HookConsumerWidget {
  final String rotationGroupId;

  const CalendarScreen({super.key, required this.rotationGroupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarDataAsync = ref.watch(
      calendarScreenDataProvider(rotationGroupId),
    );
    return calendarDataAsync.when(
      data:
          (result) => result.when(
            success:
                (calendarData) => _buildCalendarScreen(context, calendarData),
            failure: (error) => customErrorWidget(context, error.message),
          ),
      loading: () => customLoadingWidget(context),
      error: (error, stack) => customErrorWidget(context, error.toString()),
    );
  }

  Widget _buildCalendarScreen(
    BuildContext context,
    CalendarDataDto calendarData,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final focusedDay = useState(DateTime.now().toLocal());
    final selectedDay = useState<DateTime?>(DateTime.now().toLocal());
    final rotationGroup = calendarData.rotationGroup;
    final notificationDetails = calendarData.notificationDetails;

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: rotationGroup.rotationName,
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
                        rotationGroup,
                        focusedDay,
                        selectedDay,
                        notificationDetails,
                      ),
                      const SizedBox(height: 16),
                      _buildSelectedDayInfo(
                        rotationGroup,
                        selectedDay.value,
                        notificationDetails,
                        glassTheme,
                        textTheme,
                      ),
                      const SizedBox(height: 16),
                      _buildRotationInfo(context, rotationGroup),
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
    RotationGroup rotationGroup,
    ValueNotifier<DateTime> focusedDay,
    ValueNotifier<DateTime?> selectedDay,
    List<NotificationDetail> notificationDetails,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return GlassWrapper(
      child: TableCalendar<String>(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: focusedDay.value,
        selectedDayPredicate: (day) => isSameDay(selectedDay.value, day),
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
              notificationDetails,
              day,
              rotationGroup,
              false,
              false,
            );
          },
          // 今日の日付
          todayBuilder: (context, day, focusedDay) {
            return _buildCalendarCell(
              context,
              notificationDetails,
              day,
              rotationGroup,
              true,
              false,
            );
          },
          // 選択された日付
          selectedBuilder: (context, day, focusedDay) {
            return _buildCalendarCell(
              context,
              notificationDetails,
              day,
              rotationGroup,
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
    List<NotificationDetail> notificationDetails,
    DateTime day,
    RotationGroup rotationGroup,
    bool isToday,
    bool isSelected,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    // 通知詳細から該当日の担当者を取得
    final notification = notificationDetails.firstWhere(
      (detail) => isSameDay(detail.date, day),
      orElse:
          () => NotificationDetail(
            notificationId: 0,
            date: day,
            memberName: '',
            title: '',
            body: '',
          ),
    );
    final memberName = notification.memberName;
    final isRotationDay = memberName.isNotEmpty;

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
          isRotationDay
              ? Text(
                memberName,
                style: textTheme.labelMedium!.copyWith(
                  color: getMemberColor(memberName, rotationGroup),
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
    RotationGroup rotationGroup,
    DateTime? selectedDay,
    List<NotificationDetail> notificationDetails,
    GlassTheme glass,
    TextTheme textTheme,
  ) {
    if (selectedDay == null) {
      return const SizedBox.shrink();
    }

    // 通知詳細から該当日の情報を取得
    final notification = notificationDetails.firstWhere(
      (detail) => isSameDay(detail.date, selectedDay),
      orElse:
          () => NotificationDetail(
            notificationId: 0,
            date: selectedDay,
            memberName: '',
            title: '',
            body: '',
          ),
    );

    final memberName = notification.memberName;
    final isRotationDay = memberName.isNotEmpty;

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
                        text: isRotationDay ? "担当日" : "対象外",
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
                        isRotationDay ? memberName : 'ローテーション対象外',
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
  Widget _buildRotationInfo(BuildContext context, RotationGroup rotationGroup) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return GlassWrapper(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ローテーション情報
            _rotationInfoItem(
              textTheme,
              glassTheme,
              'ローテーション情報',
              Icons.info_outline,
              iconSize: 20,
              textStyle: textTheme.titleMedium,
            ),
            const SizedBox(height: 14),
            // メンバー
            _rotationInfoItem(
              textTheme,
              glassTheme,
              'メンバー: ${rotationGroup.rotationMembers.join(', ')}',
              Icons.group,
            ),
            const SizedBox(height: 12),
            // 曜日
            _rotationInfoItem(
              textTheme,
              glassTheme,
              '曜日: ${rotationGroup.rotationDays.map((w) => w.displayName).join(', ')}',
              Icons.calendar_today,
            ),
            const SizedBox(height: 12),
            // 通知時刻
            _rotationInfoItem(
              textTheme,
              glassTheme,
              '時刻: ${rotationGroup.notificationTime.hour.toString().padLeft(2, '0')}:${rotationGroup.notificationTime.minute.toString().padLeft(2, '0')}',
              Icons.access_time,
            ),
          ],
        ),
      ),
    );
  }

  Widget _rotationInfoItem(
    TextTheme textTheme,
    GlassTheme glassTheme,
    String infoText,
    IconData iconData, {
    double iconSize = 18,
    TextStyle? textStyle,
  }) {
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
