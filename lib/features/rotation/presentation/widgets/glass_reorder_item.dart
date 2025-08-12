import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassReorderItem extends StatelessWidget {
  const GlassReorderItem({
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
