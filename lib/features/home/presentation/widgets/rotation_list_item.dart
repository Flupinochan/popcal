import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

class RotationListItem extends StatelessWidget {
  final RotationGroup rotationGroup;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const RotationListItem({
    super.key,
    required this.rotationGroup,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: Key(rotationGroup.rotationGroupId ?? ''),
        direction: DismissDirection.horizontal,
        background: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: GlassmorphicContainer(
            width: double.infinity,
            height: 80,
            borderRadius: 16,
            blur: 20,
            alignment: Alignment.centerRight,
            border: 1,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red.withOpacity(0.3),
                Colors.red.withOpacity(0.1),
              ],
              stops: const [0.1, 1],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.red.withOpacity(0.4),
                Colors.red.withOpacity(0.4),
              ],
            ),
          ),
        ),
        confirmDismiss: (direction) async {
          onDelete?.call();
          return false;
        },
        child: GlassmorphicContainer(
          width: double.infinity,
          height: 80,
          borderRadius: 16,
          blur: 20,
          alignment: Alignment.center,
          border: 1,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.15),
              const Color(0xFFffffff).withOpacity(0.05),
            ],
            stops: const [0.1, 1],
          ),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.3),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // アイコン
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.group,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // テキスト情報
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            rotationGroup.rotationName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${rotationGroup.rotationMembers.length}人のメンバー',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // カスタム PopupMenu ボタン
                    _buildCustomPopupMenu(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomPopupMenu(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showCustomMenu(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(
            Icons.more_vert,
            color: Colors.white.withOpacity(0.8),
            size: 20,
          ),
        ),
      ),
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
