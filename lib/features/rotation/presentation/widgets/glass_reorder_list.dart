import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

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
      proxyDecorator: (child, index, animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return _GlassReorderItem(
              key: ValueKey(items[index]),
              index: index,
              item: items[index],
              onDelete: () => onDelete(index),
              isDragging: true,
            );
          },
        );
      },
      // 通常時のスタイル
      itemBuilder: (context, index) {
        return _GlassReorderItem(
          key: ValueKey(items[index]),
          index: index,
          item: items[index],
          onDelete: () => onDelete(index),
          isDragging: false,
        );
      },
    );
  }
}

class _GlassReorderItem extends StatelessWidget {
  const _GlassReorderItem({
    required this.index,
    required this.item,
    required this.onDelete,
    required this.isDragging,
    super.key,
  });
  final int index;
  final String item;
  final VoidCallback onDelete;
  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final textTheme = Theme.of(context).textTheme;

    // reorder時はスタイル変更
    return Transform.scale(
      // スケール1.05
      scale: isDragging ? 1.05 : 1.0,
      child: GlassWrapper(
        key: ValueKey(item),
        // border表示
        showBorder: isDragging,
        // 背景濃く
        gradient:
            isDragging
                ? glassTheme.backgroundGradientStrong
                : glassTheme.backgroundGradient,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            // メンバーIndex (数字)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: Center(
                child: Text('${index + 1}', style: textTheme.titleMedium),
              ),
            ),
            const SizedBox(width: 16),
            // メンバー名
            Expanded(child: Text(item, style: textTheme.bodyLarge)),
            // 削除ボタン
            IconButton(
              icon: Icon(Icons.close, color: glassTheme.iconColor, size: 20),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
