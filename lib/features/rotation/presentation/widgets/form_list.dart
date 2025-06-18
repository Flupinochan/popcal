import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:popcal/features/rotation/presentation/widgets/reorder_list.dart';

class FormList extends HookWidget {
  final String name;
  final String hintText;
  final List<String> initialValue;
  final String? Function(List<String>?)? validator;

  const FormList({
    super.key,
    required this.name,
    required this.hintText,
    this.initialValue = const [],
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final items = useState<List<String>>(List.from(initialValue));

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
                // テキスト入力
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: (_) => _addItem(controller, items, field),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () => _addItem(controller, items, field),
                    icon: Icon(Icons.add, color: Colors.white),
                    padding: EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // chip Listの表示
            ReorderList(
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
                  style: TextStyle(color: Colors.red, fontSize: 12),
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
