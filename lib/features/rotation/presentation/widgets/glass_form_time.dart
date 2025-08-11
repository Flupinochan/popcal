import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassFormTime extends StatelessWidget {
  const GlassFormTime({required this.now, super.key, this.initialValue});
  final TimeOfDay? initialValue;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final textTheme = Theme.of(context).textTheme;
    // ローカル日時で指定
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
    final surfaceColorLight = glassTheme.surfaceColor.withValues(alpha: 0.15);
    final surfaceColorMedium = glassTheme.surfaceColor.withValues(alpha: 0.4);

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
            // ignore: avoid-passing-async-when-sync-expected
            onTap: () async {
              // TimePicker
              final picked = await showTimePicker(
                context: context,
                initialTime: field.value ?? const TimeOfDay(hour: 9, minute: 0),
                builder: (BuildContext context, Widget? child) {
                  // TimePicker ガラス風スタイル設定
                  return Theme(
                    data: Theme.of(context).copyWith(
                      timePickerTheme: TimePickerThemeData(
                        backgroundColor: const Color(
                          0xFF1A1A2E,
                        ).withValues(alpha: 0.9),
                        hourMinuteTextColor: glassTheme.surfaceColor,
                        hourMinuteColor: surfaceColorLight,
                        dayPeriodTextColor: glassTheme.surfaceColor,
                        dayPeriodColor: glassTheme.surfaceColor.withValues(
                          alpha: 0.3,
                        ),
                        dayPeriodBorderSide: BorderSide(
                          color: surfaceColorMedium,
                          width: 1.5,
                        ),
                        dialBackgroundColor: const Color.fromARGB(
                          255,
                          22,
                          22,
                          39,
                        ).withValues(alpha: 0.9),
                        dialHandColor: glassTheme.surfaceColor.withValues(
                          alpha: 0.5,
                        ),
                        dialTextColor: glassTheme.surfaceColor,
                        entryModeIconColor: glassTheme.surfaceColor,
                        helpTextStyle: TextStyle(
                          color: glassTheme.surfaceColor,
                        ),
                        inputDecorationTheme: InputDecorationTheme(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: glassTheme.surfaceColor.withValues(
                                alpha: 0.4,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: glassTheme.surfaceColor.withValues(
                            alpha: 0.15,
                          ),
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
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                spacing: 12,
                children: [
                  // Time Icon
                  Icon(
                    Icons.access_time,
                    color: glassTheme.surfaceColor.withValues(alpha: 0.8),
                    size: 20,
                  ),
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
