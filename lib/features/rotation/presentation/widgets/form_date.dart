import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormDate extends StatelessWidget {
  const FormDate({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: 'startDate',
      initialValue: DateTime.now(),
      inputType: InputType.date,
      decoration: InputDecoration(
        hintText: '開始日を選択してください',
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
        prefixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
      ),
    );
  }
}
