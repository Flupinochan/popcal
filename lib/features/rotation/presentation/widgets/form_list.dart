import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:popcal/features/rotation/presentation/widgets/reorder_list.dart';

class FormList extends HookWidget {
  final String name;
  final String hintText;
  final List<String>? initialValue;
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
    final defaultValue = initialValue ?? <String>[];
    final items = useState<List<String>>(List.from(defaultValue));

    // Listの場合は、FormBuilderFieldでカスタムFormFieldを作成する必要がある
    return FormBuilderField<List<String>>(
      name: name,
      initialValue: initialValue ?? ['太郎', '次郎', '三郎'],
      validator: validator,
      builder: (FormFieldState<List<String>> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // テキスト入力
                Expanded(
                  child: GlassmorphicContainer(
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
                      colors: [Colors.transparent, Colors.transparent],
                    ),
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _addItem(controller, items, field),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                GlassmorphicContainer(
                  width: 56,
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
                    colors: [Colors.transparent, Colors.transparent],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _addItem(controller, items, field),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
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
