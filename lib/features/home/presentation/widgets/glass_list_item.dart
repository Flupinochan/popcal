import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class GlassListItem extends StatelessWidget {
  const GlassListItem({
    required this.rotationResponse,
    super.key,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final RotationResponse rotationResponse;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: Key(rotationResponse.rotationId.value),
        // Dismissによる削除時の背景色
        background: GlassWrapper(
          borderColor: glassTheme.errorBorderColor,
          gradient: glassTheme.errorGradient,
          child: const SizedBox.shrink(),
        ),
        confirmDismiss: _onConfirmDismiss,
        // ListItem
        child: GlassWrapper(
          child: Material(
            color: glassTheme.backgroundColor,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // アイコン
                    const GlassIcon(iconData: Icons.group),
                    const SizedBox(width: 16),
                    // テキスト情報
                    Expanded(
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // RotationName
                          Text(
                            rotationResponse.rotationName.value,
                            style: textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // MemberNameList
                          Text(
                            rotationResponse.displayMembers,
                            style: textTheme.bodySmall,
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
                          onPressed:
                              controller.isOpen
                                  ? controller.close
                                  : controller.open,
                          // Popup Button
                          icon: Icon(
                            Icons.more_vert,
                            color: glassTheme.surfaceColor,
                          ),
                        );
                      },
                      alignmentOffset: const Offset(-77, -43),
                      style: MenuStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        elevation: WidgetStateProperty.all(0),
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            side: BorderSide(
                              color: glassTheme.borderColorStrong,
                            ),
                          ),
                        ),
                      ),
                      menuChildren: [
                        // 編集
                        MenuItemButton(
                          onPressed: onEdit,
                          // ignore: avoid-returning-widgets
                          child: _menuItem(
                            iconColor: Colors.white,
                            iconData: Icons.edit,
                            title: '編集',
                          ),
                        ),
                        // 区切り線
                        Divider(
                          color: glassTheme.borderColor,
                          height: 1,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                        // 削除
                        MenuItemButton(
                          onPressed: onDelete,
                          // ignore: avoid-returning-widgets
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
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, size: 18, color: iconColor),
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }

  Future<bool> _onConfirmDismiss(DismissDirection direction) async {
    onDelete?.call();
    return false;
  }
}
