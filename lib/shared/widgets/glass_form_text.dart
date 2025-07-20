import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassFormText extends StatelessWidget {
  final String name;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSubmitted;

  const GlassFormText({
    super.key,
    required this.name,
    this.initialValue,
    this.hintText,
    this.controller,
    this.validator,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return GlassWrapper(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: FormBuilderTextField(
        name: name,
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          filled: false,
        ),
        style: Theme.of(context).textTheme.bodyLarge,
        validator: validator,
        controller: controller,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
