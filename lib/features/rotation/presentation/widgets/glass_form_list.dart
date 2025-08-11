import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_reorder_list.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_form_text.dart';

class GlassFormList extends HookWidget {
  const GlassFormList({
    required this.name,
    required this.hintText,
    super.key,
    this.initialValue = const [],
    this.validator,
  });
  final String name;
  final String hintText;
  final List<String>? initialValue;
  final String? Function(List<String>?)? validator;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final defaultValue = initialValue ?? <String>[];
    final items = useState<List<String>>(List.of(defaultValue));

    // Listの場合は、FormBuilderFieldでカスタムFormFieldを作成する必要がある
    return FormBuilderField<List<String>>(
      name: name,
      initialValue: initialValue,
      validator: validator,
      builder: (FormFieldState<List<String>> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 12,
              children: [
                // メンバー名入力
                Expanded(
                  child: GlassFormText(
                    name: '${name}_input',
                    hintText: hintText,
                    controller: controller,
                    onSubmitted: (_) => _addItem(controller, items, field),
                  ),
                ),
                // メンバー追加+ボタン
                GlassButton(
                  iconData: Icons.add,
                  backgroundSize: 52,
                  onPressed: () => _addItem(controller, items, field),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // chip Listの表示
            GlassReorderList(
              items: items.value,
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) newIndex--;
                final newItems = List<String>.of(items.value);
                final item = newItems.removeAt(oldIndex);
                newItems.insert(newIndex, item);
                items.value = newItems;
                field.didChange(newItems);
              },
              onDelete: (index) {
                final newItems = List<String>.of(items.value);
                newItems.removeAt(index);
                items.value = newItems;
                field.didChange(newItems);
              },
            ),
            if (field.hasError)
              Text(
                field.errorText!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 12,
                ),
              ),
          ],
        );
      },
    );
  }

  // chipの追加
  void _addItem(
    TextEditingController controller,
    ValueNotifier<List<String>> items,
    FormFieldState<List<String>> field,
  ) {
    final trimmedText = controller.text.trim();
    if (trimmedText.isNotEmpty) {
      final newItems = [...items.value, trimmedText];
      items.value = newItems;
      field.didChange(newItems);
      controller.clear();
    }
  }
}
