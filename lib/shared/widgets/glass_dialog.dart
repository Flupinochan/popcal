import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/dialog_content.dart';

/// ダイアログはshowDialogメソッドで表示する
void showErrorDialog(BuildContext context, String message) {
  final glassTheme =
      Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

  showDialog<void>(
    context: context,
    builder:
        (context) => GlassDialog(
          icon: Icons.priority_high,
          message: message,
          iconColor: glassTheme.errorBorderColor,
          backgroundGradient: glassTheme.errorGradient,
          borderColor: glassTheme.errorBorderColor,
        ),
  );
}

void showInfoDialog(BuildContext context, String message) {
  final glassTheme =
      Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

  showDialog<void>(
    context: context,
    builder:
        (context) => GlassDialog(
          icon: Icons.priority_high,
          message: message,
          iconColor: glassTheme.successBorderColor,
          backgroundGradient: glassTheme.successGradient,
          borderColor: glassTheme.successBorderColor,
        ),
  );
}

class GlassDialog extends StatelessWidget {
  const GlassDialog({
    required this.icon,
    required this.message,
    required this.iconColor,
    required this.backgroundGradient,
    required this.borderColor,
    super.key,
  });

  final IconData icon;
  final String message;
  final Color iconColor;
  final Gradient backgroundGradient;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return Dialog(
      backgroundColor: glassTheme.backgroundColor,
      child: DialogContent(
        icon: icon,
        message: message,
        iconColor: iconColor,
        borderColor: borderColor,
        backgroundGradient: backgroundGradient,
        onPressed: context.pop,
      ),
    );
  }
}
