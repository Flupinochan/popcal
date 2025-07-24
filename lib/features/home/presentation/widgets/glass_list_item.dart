import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
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
        // ListItem
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
                            maxLines: 1,
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
                    MenuAnchor(
                      builder: (context, controller, child) {
                        return IconButton(
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                          // Popup Button
                          icon: Icon(
                            Icons.more_vert,
                            color: glass.surfaceColor,
                          ),
                        );
                      },
                      alignmentOffset: Offset(-77, -43),
                      style: MenuStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        elevation: WidgetStateProperty.all(0),
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: glass.borderColorStrong),
                          ),
                        ),
                      ),
                      menuChildren: [
                        // 編集
                        MenuItemButton(
                          onPressed: onEdit,
                          child: _menuItem(
                            iconColor: Colors.white,
                            iconData: Icons.edit,
                            title: '編集',
                          ),
                        ),
                        // 区切り線
                        Divider(
                          color: glass.borderColor,
                          height: 1,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        // 削除
                        MenuItemButton(
                          onPressed: onDelete,
                          child: _menuItem(
                            iconColor: Colors.redAccent,
                            iconData: Icons.delete,
                            title: '削除',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    required String title,
    required IconData iconData,
    required Color iconColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, size: 18, color: iconColor),
        SizedBox(width: 8),
        Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }
}
