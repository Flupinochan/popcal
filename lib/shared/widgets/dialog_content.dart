import 'package:flutter/material.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class DialogContent extends StatelessWidget {
  const DialogContent({
    required this.icon,
    required this.message,
    required this.iconColor,
    required this.borderColor,
    required this.backgroundGradient,
    required this.onPressed,
    super.key,
  });

  final IconData icon;
  final String message;
  final Color iconColor;
  final Color borderColor;
  final Gradient backgroundGradient;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return IntrinsicHeight(
      child: GlassWrapper(
        width: 300,
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 20,
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
            Text(
              message,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            GlassButton(
              text: 'OK',
              height: 44,
              onPressed: onPressed,
              // onPressed: context.pop,
              // onPressed: () => const HomeRoute().go(context),
            ),
          ],
        ),
      ),
    );
  }
}
