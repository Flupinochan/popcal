import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassListItem extends StatelessWidget {
  final RotationGroup rotationGroup;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const GlassListItem({
    super.key,
    required this.rotationGroup,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: Key(rotationGroup.rotationGroupId ?? ''),
        direction: DismissDirection.horizontal,
        // Dismissによる削除時の背景色
        background: GlassWrapper(
          borderColor: glass.errorBorderColor,
          gradient: glass.errorGradient,
          child: const SizedBox.shrink(),
        ),
        confirmDismiss: (direction) async {
          onDelete?.call();
          return false;
        },
        // Item
        child: GlassWrapper(
          child: Material(
            color: glass.backgroundColor,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // アイコン
                    GlassIcon(iconData: Icons.group),
                    const SizedBox(width: 16),
                    // テキスト情報
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // RotationGroupName
                          Text(
                            rotationGroup.rotationName,
                            style: Theme.of(context).textTheme.titleMedium,
                            // 1行に制限
                            maxLines: 1,
                            // はみ出し部分を...で表示
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // MemberNameList
                          Text(
                            rotationGroup.rotationMembers.join(', '),
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // ポップアップボタン (編集/削除)
                    _buildPopupButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupButton(BuildContext context) {
    return GlassButton(
      showBorder: false,
      showBackground: false,
      iconData: Icons.more_vert,
      onPressed: () => _showCustomMenu(context),
    );
  }

  void _showCustomMenu(BuildContext context) async {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    await showDialog<String>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext dialogContext) {
        return Stack(
          children: [
            // 透明な背景でタップ時にメニューを閉じる
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(dialogContext).pop(),
                child: Container(color: Colors.transparent),
              ),
            ),
            // メニューを右上に配置
            Positioned(
              left: offset.dx + size.width - 120,
              top: offset.dy + 20,
              child: Material(
                color: Colors.transparent,
                child: IntrinsicWidth(
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 100),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.15),
                          const Color(0xFFffffff).withOpacity(0.05),
                        ],
                        stops: const [0.1, 1],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildMenuItem(
                          icon: Icons.edit,
                          text: '編集',
                          iconColor: Colors.white.withOpacity(0.8),
                          onTap: () {
                            Navigator.of(dialogContext).pop(); // ダイアログを閉じる
                            onEdit?.call(); // 編集画面に遷移
                          },
                          isFirst: true,
                        ),
                        Container(
                          height: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        _buildMenuItem(
                          icon: Icons.delete,
                          text: '削除',
                          iconColor: Colors.red.withOpacity(0.8),
                          onTap: () {
                            Navigator.of(dialogContext).pop(); // ダイアログを閉じる
                            onDelete?.call(); // 削除処理
                          },
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required Color iconColor,
    required VoidCallback onTap,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? const Radius.circular(12) : Radius.zero,
          topRight: isFirst ? const Radius.circular(12) : Radius.zero,
          bottomLeft: isLast ? const Radius.circular(12) : Radius.zero,
          bottomRight: isLast ? const Radius.circular(12) : Radius.zero,
        ),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 18),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
