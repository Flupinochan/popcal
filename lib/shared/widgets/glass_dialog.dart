import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassDialog extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color iconColor;
  final Gradient backgroundGradient;
  final Color borderColor;

  const GlassDialog({
    super.key,
    required this.icon,
    required this.message,
    required this.iconColor,
    required this.backgroundGradient,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme = Theme.of(context).extension<GlassTheme>()!;

    return Dialog(
      backgroundColor: glassTheme.backgroundColor,
      child: IntrinsicHeight(
        child: GlassWrapper(
          width: 300,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlassIcon(
                iconData: icon,
                backgroundSize: 50,
                iconSize: 40,
                iconColor: iconColor,
                showBorder: true,
                backgroundGradient: backgroundGradient,
                borderColor: borderColor,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GlassButton(
                text: 'OK',
                height: 44,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showErrorDialog(BuildContext context, String message) {
  final glassTheme = Theme.of(context).extension<GlassTheme>()!;

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
  final glassTheme = Theme.of(context).extension<GlassTheme>()!;

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
