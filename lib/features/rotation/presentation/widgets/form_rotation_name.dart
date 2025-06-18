import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormRotationName extends StatelessWidget {
  const FormRotationName({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'rotationName', // formData['rotationName'] で参照可能
      initialValue: "テスト",
      decoration: InputDecoration(
        hintText: 'ローテーション名を入力してください',
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
      // バリデーション
      validator: FormBuilderValidators.required(errorText: 'ローテーション名を入力してください'),
    );
  }
}
