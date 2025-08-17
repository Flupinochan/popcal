import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/shared/widgets/glass_button.dart';

class GlassFormWeekday extends StatelessWidget {
  const GlassFormWeekday({required this.now, super.key, this.initialValue});

  final List<Weekday>? initialValue;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return FormBuilderField<List<Weekday>>(
      name: 'rotationDays',
      initialValue: initialValue ?? [Weekday.fromDateTime(now)],
      validator:
          (value) =>
              (value == null || value.isEmpty) ? '曜日を1つ以上選択してください' : null,
      builder: (FormFieldState<List<Weekday>> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  [
                        Weekday.monday,
                        Weekday.tuesday,
                        Weekday.wednesday,
                        Weekday.thursday,
                        Weekday.friday,
                        Weekday.saturday,
                        Weekday.sunday,
                      ]
                      .map(
                        (weekday) =>
                            _buildWeekdayButton(weekday, field, glassTheme),
                      )
                      .toList(),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
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
      showBackground: isSelected,
      gradient:
          isSelected
              ? glass.backgroundGradientStrong
              : glass.backgroundGradient,
      text: weekday.displayName,
      onPressed: () => _onWeekdayPressed(weekday, field, isSelected),
    );
  }

  void _onWeekdayPressed(
    Weekday weekday,
    FormFieldState<List<Weekday>> field,
    bool isSelected,
  ) {
    final currentValue = field.value ?? <Weekday>[];
    final newValue =
        isSelected
            ? currentValue.where((w) => w != weekday).toList()
            : [...currentValue, weekday];
    field.didChange(newValue);
  }
}
