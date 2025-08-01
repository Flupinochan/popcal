import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassToggleButton extends StatelessWidget {
  final String text;
  // 選択状態に応じてテーマを切り替えるButton
  final bool isSelected;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const GlassToggleButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return GlassWrapper(
      width: width,
      height: height,
      showBorder: isSelected,
      gradient: isSelected ? glassTheme.backgroundGradientStrong : null,
      borderColor: glassTheme.borderColorStrong,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style:
                  isSelected
                      ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                      : Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
