import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormRotationType extends StatelessWidget {
  const FormRotationType({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<String>(
      name: 'rotationType',
      initialValue: 'roleRotation',
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      items: [
        DropdownMenuItem(value: 'roleFixed', child: Text('役割固定')),
        DropdownMenuItem(value: 'roleRotation', child: Text('役割もローテーション')),
      ],
    );
  }
}
