import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glassmorphism/glassmorphism.dart';

class FormTimeSelector extends StatelessWidget {
  final TimeOfDay? initialValue;

  const FormTimeSelector({super.key, this.initialValue});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

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
          timePickerTheme: TimePickerThemeData(
            backgroundColor: const Color(0xFF1A1A2E),
            hourMinuteTextColor: Colors.white,
            hourMinuteColor: Colors.white.withOpacity(0.1),
            dayPeriodTextColor: Colors.white,
            dayPeriodColor: Colors.white.withOpacity(0.1),
            dialBackgroundColor: const Color(0xFF16213E),
            dialHandColor: Colors.white,
            dialTextColor: Colors.white,
            entryModeIconColor: Colors.white,
            helpTextStyle: const TextStyle(color: Colors.white),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          ),
          colorScheme: const ColorScheme.dark(
            surface: Color(0xFF1A1A2E),
            onSurface: Colors.white,
            primary: Colors.white,
            onPrimary: Color(0xFF1A1A2E),
          ),
        ),
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
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime:
                      field.value ?? const TimeOfDay(hour: 9, minute: 0),
                );
                if (picked != null) {
                  field.didChange(picked);
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.white.withOpacity(0.8),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        timeText,
                        style: TextStyle(
                          color:
                              field.value != null
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
