import 'package:flutter/material.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_reorder_item.dart';

class GlassReorderList extends StatelessWidget {
  const GlassReorderList({
    required this.items,
    required this.onReorder,
    required this.onDelete,
    super.key,
  });
  final List<String> items;
  final void Function(int, int) onReorder;
  final void Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      onReorder: onReorder,
      // 並べ替え時のスタイル
      proxyDecorator: _proxyDecorator,
      // 通常時のスタイル
      itemBuilder: (context, index) {
        return GlassReorderItem(
          key: ValueKey(items[index]),
          index: index,
          item: items[index],
          onDelete: () => onDelete(index),
          isDragging: false,
        );
      },
    );
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return GlassReorderItem(
          key: ValueKey(items[index]),
          index: index,
          item: items[index],
          onDelete: () => onDelete(index),
          isDragging: true,
        );
      },
    );
  }
}
