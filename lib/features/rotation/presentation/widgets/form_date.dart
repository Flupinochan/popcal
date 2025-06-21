import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glassmorphism/glassmorphism.dart';

class FormDate extends StatelessWidget {
  const FormDate({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 56,
      borderRadius: 12,
      blur: 20,
      alignment: Alignment.center,
      border: 0,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.1),
          const Color(0xFFffffff).withOpacity(0.05),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.5),
          const Color(0xFFffffff).withOpacity(0.5),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
            backgroundColor: Color(0xFF1A1A2E),
            headerBackgroundColor: Color(0xFF16213E),
            headerForegroundColor: Colors.white,
            dayStyle: TextStyle(color: Colors.white),
            weekdayStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
            yearStyle: TextStyle(color: Colors.white),
            dayForegroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Color(0xFF1A1A2E);
              }
              return Colors.white;
            }),
            dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return Colors.transparent;
            }),
            todayForegroundColor: WidgetStateProperty.resolveWith((states) {
              return Colors.white;
            }),
            todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
              return Colors.white.withOpacity(0.1);
            }),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          ),
          colorScheme: ColorScheme.dark(
            surface: Color(0xFF1A1A2E),
            onSurface: Colors.white,
            primary: Colors.white,
            onPrimary: Color(0xFF1A1A2E),
          ),
        ),
        child: FormBuilderDateTimePicker(
          name: 'notificationTime',
          initialValue: DateTime.now(),
          inputType: InputType.date,
          decoration: InputDecoration(
            hintText: '開始日を選択してください',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            prefixIcon: Icon(
              Icons.calendar_today,
              color: Colors.white.withOpacity(0.8),
              size: 20,
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
