import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';

class FormWeekdaySelector extends StatelessWidget {
  final List<Weekday>? initialValue;

  const FormWeekdaySelector({super.key, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<Weekday>>(
      name: 'rotationDays',
      initialValue: initialValue ?? [Weekday.monday],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '曜日を1つ以上選択してください';
        }
        return null;
      },
      builder: (FormFieldState<List<Weekday>> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 曜日ボタン（日〜土）
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  [
                        Weekday.sunday,
                        Weekday.monday,
                        Weekday.tuesday,
                        Weekday.wednesday,
                        Weekday.thursday,
                        Weekday.friday,
                        Weekday.saturday,
                      ]
                      .map((weekday) => _buildWeekdayButton(weekday, field))
                      .toList(),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildWeekdayButton(
    Weekday weekday,
    FormFieldState<List<Weekday>> field,
  ) {
    final isSelected = field.value?.contains(weekday) ?? false;

    return GlassmorphicContainer(
      width: 44,
      height: 44,
      borderRadius: 22,
      blur: 15,
      alignment: Alignment.center,
      border: isSelected ? 2 : 0,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(isSelected ? 0.3 : 0.1),
          Colors.white.withOpacity(isSelected ? 0.15 : 0.05),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(isSelected ? 0.6 : 0.2),
          Colors.white.withOpacity(isSelected ? 0.6 : 0.2),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            final currentValue = List<Weekday>.from(field.value ?? []);
            if (isSelected) {
              currentValue.remove(weekday);
            } else {
              currentValue.add(weekday);
            }
            field.didChange(currentValue);
          },
          borderRadius: BorderRadius.circular(22),
          child: Center(
            child: Text(
              weekday.displayName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
