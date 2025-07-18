import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';

class RotationListItem extends StatelessWidget {
  final RotationGroup rotationGroup;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const RotationListItem({
    super.key,
    required this.rotationGroup,
    this.onTap,
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
        // onDismissedの代わりにconfirmDismissを使用
        confirmDismiss: (direction) async {
          // 削除処理を実行
          onDelete?.call();
          // 常にfalseを返してDismissibleを削除しない
          // （実際の削除はFirestoreで行われ、Streamで自動的に更新される）
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
