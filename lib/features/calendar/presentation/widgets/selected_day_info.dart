import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/presentation/widgets/glass_chip.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class SelectedDayInfo extends StatelessWidget {
  const SelectedDayInfo({
    required this.calendarScheduleResponse,
    required this.selectedDay,
    super.key,
  });

  final CalendarScheduleResponse calendarScheduleResponse;
  final DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    if (selectedDay == null) {
      return const SizedBox.shrink();
    }

    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final dayInfo = calendarScheduleResponse.getDayInfo(selectedDay!);
    final memberName = dayInfo.memberName;
    final isRotationDay = dayInfo.isRotationDay;
    final iconColor =
        isRotationDay
            ? glassTheme.surfaceColor
            : glassTheme.surfaceColor.withValues(alpha: 0.6);

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
              gradient: glassTheme.backgroundGradientStrong,
              child: Center(
                child: Text(
                  '${selectedDay!.month}/${selectedDay!.day}',
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
                          Weekday.fromDateTime(selectedDay!).displayName,
                          style: textTheme.titleMedium,
                        ),
                      ),
                      // 担当日/対象外
                      GlassChip(
                        text: dayInfo.displayText,
                        gradient:
                            isRotationDay
                                ? glassTheme.successGradient
                                : glassTheme.backgroundGradientStrong,
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
