import 'package:flutter/material.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassChip extends StatelessWidget {
  const GlassChip({super.key, required this.text, required this.gradient});

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GlassWrapper(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      showBorder: false,
      gradient: gradient,
      child: Text(text, style: textTheme.labelMedium),
    );
  }
}
