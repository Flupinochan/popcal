import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassFormTime extends StatelessWidget {
  final TimeOfDay? initialValue;
  final DateTime now;

  const GlassFormTime({super.key, this.initialValue, required this.now});

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final textTheme = Theme.of(context).textTheme;
    // ローカル日時で指定
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    return GlassWrapper(
      child: FormBuilderField<TimeOfDay>(
        name: 'notificationTime',
        initialValue: initialValue ?? currentTime,
        validator: (value) {
          if (value == null) {
            return '通知時刻を選択してください';
          }
          return null;
        },
        builder: (FormFieldState<TimeOfDay> field) {
          final timeText =
              field.value != null
                  ? '${field.value!.hour.toString().padLeft(2, '0')}:${field.value!.minute.toString().padLeft(2, '0')}'
                  : '時刻を選択してください';

          return InkWell(
            onTap: () async {
              // TimePicker
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: field.value ?? const TimeOfDay(hour: 9, minute: 0),
                builder: (BuildContext context, Widget? child) {
                  // TimePicker ガラス風スタイル設定
                  return Theme(
                    data: Theme.of(context).copyWith(
                      timePickerTheme: TimePickerThemeData(
                        backgroundColor: Color(
                          0xFF1A1A2E,
                        ).withValues(alpha: 0.9),
                        hourMinuteTextColor: Colors.white,
                        hourMinuteColor: Colors.white.withValues(alpha: 0.15),
                        dayPeriodTextColor: Colors.white,
                        dayPeriodColor: Colors.white.withValues(alpha: 0.3),
                        dayPeriodBorderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        dialBackgroundColor: Color.fromARGB(
                          255,
                          22,
                          22,
                          39,
                        ).withValues(alpha: 0.9),
                        dialHandColor: Colors.white.withValues(alpha: 0.5),
                        dialTextColor: Colors.white,
                        entryModeIconColor: Colors.white,
                        helpTextStyle: TextStyle(color: Colors.white),
                        inputDecorationTheme: InputDecorationTheme(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.15),
                        ),
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: glassTheme.iconColor,
                        ),
                      ),
                    ),
                    // 24時間表記
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      ),
                    ),
                  );
                },
              );
              if (picked != null) {
                field.didChange(picked);
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Time Icon
                  Icon(
                    Icons.access_time,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  // Time Text
                  Expanded(child: Text(timeText, style: textTheme.bodyLarge)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
