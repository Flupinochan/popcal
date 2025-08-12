import 'package:flutter/material.dart';
import 'package:popcal/shared/widgets/glass_button.dart';

class GlassMenuItem extends StatelessWidget {
  const GlassMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      iconData: icon,
      text: title,
      onPressed: onTap,
      alignment: Alignment.centerLeft,
    );
  }
}
