import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_app_bar/sync_status.dart';

class SyncStatusIndicator extends StatelessWidget {
  const SyncStatusIndicator({
    required this.syncStatus,
    super.key,
  });

  final SyncStatus? syncStatus;

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    switch (syncStatus) {
      case SyncStatus.syncing:
        return SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: glassTheme.surfaceColor,
          ),
        );
      case SyncStatus.completed:
        return Icon(
          Icons.check_circle_outline,
          color: glassTheme.successBorderColor,
        );
      case SyncStatus.failed:
        return Icon(Icons.error_outline, color: glassTheme.errorBorderColor);
      case SyncStatus.idle:
      case null:
        return const SizedBox();
    }
  }
}
