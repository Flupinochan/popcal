import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_app_bar/sync_status.dart';
import 'package:popcal/shared/widgets/glass_app_bar/sync_status_indicator.dart';

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
          child: SyncStatusIndicator(syncStatus: syncStatus),
        ),
      ],
      iconTheme: IconThemeData(color: glassTheme.surfaceColor),
    );
  }
}
