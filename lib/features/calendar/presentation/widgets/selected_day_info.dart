import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/calendar/domain/value_objects/date_key.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/presentation/widgets/glass_chip.dart';
import 'package:popcal/features/calendar/providers/calendar_loader.dart';
import 'package:popcal/features/rotation/domain/enums/schedule_day_type.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_count.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_event.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_request.dart';
import 'package:popcal/features/rotation/providers/rotation_notifier.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_dialog.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class SelectedDayInfo extends ConsumerWidget {
  const SelectedDayInfo({
    required this.calendarScheduleResponse,
    required this.selectedDay,
    super.key,
  });

  final CalendarScheduleResponse calendarScheduleResponse;
  final DateTime? selectedDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (selectedDay == null) {
      return const SizedBox.shrink();
    }

    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final dayInfo = calendarScheduleResponse.getDayInfo(selectedDay!);
    final memberName = dayInfo.memberName;
    final scheduleDayType = dayInfo.scheduleDayType;
    final iconColor = scheduleDayType.iconColor;
    final canSkipNext = dayInfo.canSkipNext;
    final canSkipPrevious = dayInfo.canSkipPrevious;
    final canDisableHoliday = dayInfo.canDisableHoliday;
    final canEnableHoliday = dayInfo.canEnableHoliday;
    final isValidRotationDay = dayInfo.isValidRotationDay;

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
                          style: textTheme.titleMedium?.copyWith(
                            color: Weekday.getWeekDayColor(
                              selectedDay!.weekday,
                            ),
                          ),
                        ),
                      ),
                      // 担当日/対象外
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: GlassChip(
                          text: dayInfo.displayText,
                          gradient: scheduleDayType.isRotationColor,
                        ),
                      ),
                      if (canEnableHoliday)
                        GlassButton(
                          iconSize: 14,
                          iconData: Icons.alarm_on,
                          borderRadius: 4,
                          onPressed:
                              () => _enableHoliday(
                                context: context,
                                ref: ref,
                                calendarScheduleResponse:
                                    calendarScheduleResponse,
                                selectedDay: selectedDay,
                              ),
                        )
                      else if (canDisableHoliday)
                        GlassButton(
                          iconSize: 14,
                          iconData: Icons.alarm_off,
                          borderRadius: 4,
                          onPressed:
                              () => _disableHoliday(
                                context: context,
                                ref: ref,
                                calendarScheduleResponse:
                                    calendarScheduleResponse,
                                selectedDay: selectedDay,
                              ),
                        ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      if (canSkipPrevious)
                        GlassButton(
                          iconSize: 14,
                          iconData: Icons.skip_previous,
                          borderRadius: 4,
                          onPressed:
                              () => _skipPrevious(
                                context: context,
                                ref: ref,
                                calendarScheduleResponse:
                                    calendarScheduleResponse,
                                selectedDay: selectedDay,
                              ),
                        ),
                      Row(
                        spacing: 4,
                        children: [
                          // Icon
                          Container(
                            width: 24,
                            height: 24,
                            alignment: Alignment.center,
                            child: Icon(
                              isValidRotationDay
                                  ? Icons.person
                                  : Icons.person_off,
                              color: iconColor,
                              size: 20,
                            ),
                          ),
                          // メンバー名
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(
                              memberName.value,
                              style: textTheme.titleMedium!.copyWith(
                                color: iconColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (canSkipNext)
                        GlassButton(
                          iconSize: 14,
                          iconData: Icons.skip_next,
                          borderRadius: 4,
                          onPressed:
                              () => _skipNext(
                                context: context,
                                ref: ref,
                                calendarScheduleResponse:
                                    calendarScheduleResponse,
                                selectedDay: selectedDay,
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

  Future<void> _disableHoliday({
    required BuildContext context,
    required WidgetRef ref,
    required CalendarScheduleResponse calendarScheduleResponse,
    required DateTime? selectedDay,
  }) async {
    if (selectedDay == null) {
      return;
    }
    final dateKeyResult = DateKey.create(selectedDay);
    if (dateKeyResult.isFailure) {
      showErrorDialog(context, dateKeyResult.displayText);
      return;
    }

    final rotationNotifier = ref.read(rotationNotifierProvider.notifier);
    final rotationResponse = calendarScheduleResponse.rotationResponse;
    final skipEvents = rotationResponse.skipEvents.removeByDateKey(
      dateKeyResult.valueOrNull!,
    );
    final rotationId = rotationResponse.rotationId;
    final updateRotation = UpdateRotationRequest(
      userId: rotationResponse.userId,
      rotationId: rotationId,
      rotationName: rotationResponse.rotationName,
      rotationMembers: rotationResponse.rotationMembers,
      rotationDays: rotationResponse.rotationDays,
      notificationTime: rotationResponse.notificationTime,
      createdAt: rotationResponse.createdAt,
      skipEvents: skipEvents,
    );
    await rotationNotifier.updateRotation(updateRotation);
    final _ = ref.refresh(calendarScheduleResponseProvider(rotationId));
  }

  Future<void> _enableHoliday({
    required BuildContext context,
    required WidgetRef ref,
    required CalendarScheduleResponse calendarScheduleResponse,
    required DateTime? selectedDay,
  }) async {
    if (selectedDay == null) {
      return;
    }
    final dateKeyResult = DateKey.create(selectedDay);
    if (dateKeyResult.isFailure) {
      showErrorDialog(context, dateKeyResult.displayText);
      return;
    }

    final rotationResponse = calendarScheduleResponse.rotationResponse;
    // holidayの場合はskipCount1で固定
    final skipEventsResult = rotationResponse.skipEvents.add(
      SkipEvent(
        dateKey: dateKeyResult.valueOrNull!,
        dayType: DayType.holiday,
        skipCount: const SkipCount(skipCount: 1),
      ),
    );
    if (skipEventsResult.isFailure) {
      showErrorDialog(context, skipEventsResult.displayText);
      return;
    }
    final skipEvents = skipEventsResult.valueOrNull!;

    final rotationId = rotationResponse.rotationId;
    final updateRotation = UpdateRotationRequest(
      userId: rotationResponse.userId,
      rotationId: rotationId,
      rotationName: rotationResponse.rotationName,
      rotationMembers: rotationResponse.rotationMembers,
      rotationDays: rotationResponse.rotationDays,
      notificationTime: rotationResponse.notificationTime,
      createdAt: rotationResponse.createdAt,
      skipEvents: skipEvents,
    );
    final rotationNotifier = ref.read(rotationNotifierProvider.notifier);
    await rotationNotifier.updateRotation(updateRotation);
    final _ = ref.refresh(calendarScheduleResponseProvider(rotationId));
  }

  Future<void> _skipNext({
    required BuildContext context,
    required WidgetRef ref,
    required CalendarScheduleResponse calendarScheduleResponse,
    required DateTime? selectedDay,
  }) async {
    final rotationResponse = calendarScheduleResponse.rotationResponse;
    if (selectedDay == null) {
      return;
    }
    final targetDateKeyResult = DateKey.create(selectedDay);
    if (targetDateKeyResult.isFailure) {
      showErrorDialog(context, targetDateKeyResult.displayText);
      return;
    }

    final updateSkipEvents = rotationResponse.skipEvents.incrementSkipToNext(
      targetDateKeyResult.valueOrNull!,
    );

    final rotationId = rotationResponse.rotationId;
    final updateRotation = UpdateRotationRequest(
      userId: rotationResponse.userId,
      rotationId: rotationId,
      rotationName: rotationResponse.rotationName,
      rotationMembers: rotationResponse.rotationMembers,
      rotationDays: rotationResponse.rotationDays,
      notificationTime: rotationResponse.notificationTime,
      createdAt: rotationResponse.createdAt,
      skipEvents: updateSkipEvents,
    );
    final rotationNotifier = ref.read(rotationNotifierProvider.notifier);
    await rotationNotifier.updateRotation(updateRotation);
    final _ = ref.refresh(calendarScheduleResponseProvider(rotationId));
  }

  Future<void> _skipPrevious({
    required BuildContext context,
    required WidgetRef ref,
    required CalendarScheduleResponse calendarScheduleResponse,
    required DateTime? selectedDay,
  }) async {
    final rotationResponse = calendarScheduleResponse.rotationResponse;
    if (selectedDay == null) {
      return;
    }
    final targetDateKeyResult = DateKey.create(selectedDay);
    if (targetDateKeyResult.isFailure) {
      showErrorDialog(context, targetDateKeyResult.displayText);
      return;
    }

    final updateSkipEvents = rotationResponse.skipEvents.decrementSkipToNext(
      targetDateKeyResult.valueOrNull!,
    );

    final rotationId = rotationResponse.rotationId;
    final updateRotation = UpdateRotationRequest(
      userId: rotationResponse.userId,
      rotationId: rotationId,
      rotationName: rotationResponse.rotationName,
      rotationMembers: rotationResponse.rotationMembers,
      rotationDays: rotationResponse.rotationDays,
      notificationTime: rotationResponse.notificationTime,
      createdAt: rotationResponse.createdAt,
      skipEvents: updateSkipEvents,
    );
    final rotationNotifier = ref.read(rotationNotifierProvider.notifier);
    await rotationNotifier.updateRotation(updateRotation);
    final _ = ref.refresh(calendarScheduleResponseProvider(rotationId));
  }
}
