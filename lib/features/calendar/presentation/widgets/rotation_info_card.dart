import 'package:flutter/material.dart';
import 'package:popcal/features/calendar/presentation/dto/calendar_schedule_response.dart';
import 'package:popcal/features/calendar/presentation/widgets/info_row_item.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class RotationInfoCard extends StatelessWidget {
  const RotationInfoCard({
    required this.calendarScheduleResponse,
    super.key,
  });

  final CalendarScheduleResponse calendarScheduleResponse;

  @override
  Widget build(BuildContext context) {
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
                  'メンバー: ${calendarScheduleResponse.rotationResponse.displayMembers}',
              iconData: Icons.group,
            ),
            // 曜日
            InfoRowItem(
              infoText:
                  '曜日: ${calendarScheduleResponse.rotationResponse.displayDays}',
              iconData: Icons.calendar_today,
            ),
            // 通知時刻
            InfoRowItem(
              infoText:
                  '時刻: ${calendarScheduleResponse.rotationResponse.displayNotificationTime}',
              iconData: Icons.access_time,
            ),
          ],
        ),
      ),
    );
  }
}
