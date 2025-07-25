import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassReorderList extends StatelessWidget {
  final List<String> items;
  final void Function(int, int) onReorder;
  final void Function(int) onDelete;

  const GlassReorderList({
    super.key,
    required this.items,
    required this.onReorder,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return SizedBox.shrink();

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
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
  final int index;
  final String item;
  final VoidCallback onDelete;
  final bool isDragging;

  const _GlassReorderItem({
    super.key,
    required this.index,
    required this.item,
    required this.onDelete,
    required this.isDragging,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;

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
                ? glass.backgroundGradientStrong
                : glass.backgroundGradient,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            // メンバーIndex (数字)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            SizedBox(width: 16),
            // メンバー名
            Expanded(
              child: Text(item, style: Theme.of(context).textTheme.bodyLarge),
            ),
            // 削除ボタン
            IconButton(
              icon: Icon(Icons.close, color: glass.iconColor, size: 20),
              onPressed: () => onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
