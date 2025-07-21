import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingPressed;

  const GlassAppBar({
    super.key,
    required this.title,
    this.leadingIcon,
    this.onLeadingPressed,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;

    return AppBar(
      backgroundColor: glass.backgroundColor,
      elevation: 0,
      title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      leading:
          leadingIcon == null
              ? null
              : IconButton(
                icon: Icon(leadingIcon, color: glass.surfaceColor),
                onPressed: onLeadingPressed,
              ),
      iconTheme: IconThemeData(color: glass.surfaceColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
