import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:popcal/shared/widgets/glass_reorder_list.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_form_text.dart';

class GlassFormList extends HookWidget {
  final String name;
  final String hintText;
  final List<String>? initialValue;
  final String? Function(List<String>?)? validator;

  const GlassFormList({
    super.key,
    required this.name,
    required this.hintText,
    this.initialValue = const [],
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final defaultValue = initialValue ?? <String>[];
    final items = useState<List<String>>(List.from(defaultValue));

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
                SizedBox(width: 12),
                // メンバー追加+ボタン
                GlassButton(
                  iconData: Icons.add,
                  iconSize: 24,
                  backgroundSize: 52,
                  onPressed: () => _addItem(controller, items, field),
                ),
              ],
            ),
            SizedBox(height: 12),
            // chip Listの表示
            GlassReorderList(
              items: items.value,
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) newIndex--;
                final newItems = List<String>.from(items.value);
                final item = newItems.removeAt(oldIndex);
                newItems.insert(newIndex, item);
                items.value = newItems;
                field.didChange(newItems);
              },
              onDelete: (index) {
                final newItems = List<String>.from(items.value);
                newItems.removeAt(index);
                items.value = newItems;
                field.didChange(newItems);
              },
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

  // chipの追加
  void _addItem(
    TextEditingController controller,
    ValueNotifier<List<String>> items,
    FormFieldState<List<String>> field,
  ) {
    if (controller.text.trim().isNotEmpty) {
      final newItems = [...items.value, controller.text.trim()];
      items.value = newItems;
      field.didChange(newItems);
      controller.clear();
    }
  }
}
