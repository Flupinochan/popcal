import 'package:flutter/material.dart';
import 'package:popcal/features/calendar/presentation/widgets/info_row_item.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

/// ローテーション情報
class RotationInfoCard extends StatelessWidget {
  const RotationInfoCard({
    required this.rotationResponse,
    super.key,
  });

  final RotationResponse rotationResponse;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final displayMembers = rotationResponse.displayMembers;
    final displayDays = rotationResponse.displayDays;
    final displayNotificationTime = rotationResponse.displayNotificationTime;

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
              infoText: 'メンバー: $displayMembers',
              iconData: Icons.group,
            ),
            // 曜日
            InfoRowItem(
              infoText: '曜日: $displayDays',
              iconData: Icons.calendar_today,
            ),
            // 通知時刻
            InfoRowItem(
              infoText: '時刻: $displayNotificationTime',
              iconData: Icons.access_time,
            ),
          ],
        ),
      ),
    );
  }
}
