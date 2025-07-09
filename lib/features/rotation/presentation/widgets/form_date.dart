import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glassmorphism/glassmorphism.dart';

class FormDate extends StatelessWidget {
  final DateTime? initialValue;

  const FormDate({super.key, this.initialValue});

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
          // TimePickerThemeを追加
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Color(0xFF1A1A2E),
            hourMinuteTextColor: Colors.white,
            hourMinuteColor: Colors.white.withOpacity(0.1),
            dayPeriodTextColor: Colors.white,
            dayPeriodColor: Colors.white.withOpacity(0.1),
            dialBackgroundColor: Color(0xFF16213E),
            dialHandColor: Colors.white,
            dialTextColor: Colors.white,
            entryModeIconColor: Colors.white,
            helpTextStyle: TextStyle(color: Colors.white),
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
          initialValue: initialValue ?? DateTime.now(),
          inputType: InputType.both, // 日付と時刻の両方を選択可能に
          decoration: InputDecoration(
            hintText: '開始日時を選択してください', // hintTextを更新
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
              Icons.schedule, // アイコンを日時選択用に変更
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
