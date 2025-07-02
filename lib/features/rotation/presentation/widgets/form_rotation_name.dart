import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:glassmorphism/glassmorphism.dart';

class FormRotationName extends StatelessWidget {
  final String? initialValue;

  const FormRotationName({super.key, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 60,
      borderRadius: 12,
      blur: 20,
      alignment: Alignment.bottomCenter,
      border: 0,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFffffff).withOpacity(0.1),
          Color(0xFFFFFFFF).withOpacity(0.05),
        ],
        stops: [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFffffff).withOpacity(0.5),
          Color(0xFFFFFFFF).withOpacity(0.5),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: FormBuilderTextField(
          name: 'rotationName',
          initialValue: initialValue ?? "テスト",
          decoration: InputDecoration(
            hintText: 'ローテーション名を入力してください',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            filled: false,
            contentPadding: EdgeInsets.symmetric(vertical: 16),
          ),
          style: TextStyle(color: Colors.white, fontSize: 16),
          validator: FormBuilderValidators.required(
            errorText: 'ローテーション名を入力してください',
          ),
        ),
      ),
    );
  }
}
