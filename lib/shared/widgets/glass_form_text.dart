import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassFormText extends StatelessWidget {
  final String name;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSubmitted;
  final IconData? prefixIcon;

  const GlassFormText({
    super.key,
    required this.name,
    this.initialValue,
    this.hintText,
    this.controller,
    this.validator,
    this.onSubmitted,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return GlassWrapper(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Row(
        spacing: 12,
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, color: glassTheme.iconColor, size: 20),
          ],
          Expanded(
            child: FormBuilderTextField(
              name: name,
              initialValue: initialValue,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: textTheme.bodyMedium,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                filled: false,
              ),
              style: textTheme.bodyLarge,
              validator: validator,
              controller: controller,
              onSubmitted: onSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}
