import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassAppBar({
    required this.title,
    super.key,
    this.leadingIcon,
    this.onLeadingPressed,
    this.syncStatus,
  });
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final SyncStatus? syncStatus;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: glassTheme.backgroundColor,
      elevation: 0,
      title: Text(title, style: textTheme.titleLarge),
      leading:
          leadingIcon == null
              ? null
              : IconButton(
                icon: Icon(leadingIcon, color: glassTheme.surfaceColor),
                onPressed: onLeadingPressed,
              ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _buildAction(context),
        ),
      ],
      iconTheme: IconThemeData(color: glassTheme.surfaceColor),
    );
  }

  // AppBarの右側にローディング状態を表示
  Widget _buildAction(BuildContext context) {
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
        return const SizedBox();
      case null:
        return const SizedBox();
    }
  }
}

enum SyncStatus { idle, syncing, completed, failed }
