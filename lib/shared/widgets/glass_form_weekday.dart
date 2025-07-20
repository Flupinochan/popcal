import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';
import 'package:popcal/shared/widgets/glass_button.dart';

class GlassFormWeekday extends StatelessWidget {
  final List<Weekday>? initialValue;

  const GlassFormWeekday({super.key, this.initialValue});

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;

    return FormBuilderField<List<Weekday>>(
      name: 'rotationDays',
      initialValue:
          initialValue ?? [Weekday.fromDateTime(DateTime.now().toLocal())],
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
                      .map(
                        (weekday) => _buildWeekdayButton(weekday, field, glass),
                      )
                      .toList(),
            ),
            if (field.hasError)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
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
    GlassTheme glass,
  ) {
    final isSelected = field.value?.contains(weekday) ?? false;

    return GlassButton(
      width: 44,
      height: 44,
      borderColor: isSelected ? glass.borderColorStrong : glass.borderColor,
      gradient:
          isSelected
              ? glass.backgroundGradientStrong
              : glass.backgroundGradient,
      text: weekday.displayName,
      onPressed: () {
        final currentValue = List<Weekday>.from(field.value ?? []);
        if (isSelected) {
          currentValue.remove(weekday);
        } else {
          currentValue.add(weekday);
        }
        field.didChange(currentValue);
      },
    );
  }
}
