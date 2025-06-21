import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/home/presentation/widgets/empty_state.dart';
import 'package:popcal/features/home/presentation/widgets/rotation_list_item.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/glass_snackbar_content.dart';
import 'package:popcal/shared/widgets/glass_snackbar_content_with_action.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ハードコーディングしたローテーショングループのリスト
  List<RotationGroup> rotationGroups = [
    RotationGroup(
      rotationGroupId: '1',
      ownerUserId: 'user123',
      rotationName: '掃除当番',
      rotationMembers: ['太郎', '次郎', '三郎'],
      notificationTime: DateTime.now(),
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    RotationGroup(
      rotationGroupId: '2',
      ownerUserId: 'user123',
      rotationName: '料理担当',
      rotationMembers: ['田中', '佐藤', '鈴木', '高橋'],
      notificationTime: DateTime.now(),
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    RotationGroup(
      rotationGroupId: '3',
      ownerUserId: 'user123',
      rotationName: '洗濯当番',
      rotationMembers: ['山田', '中村'],
      notificationTime: DateTime.now(),
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now(),
    ),
    RotationGroup(
      rotationGroupId: '4',
      ownerUserId: 'user123',
      rotationName: '会議司会',
      rotationMembers: ['部長', '課長', '主任', '係長', '一般社員'],
      notificationTime: DateTime.now(),
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  void dispose() {
    // SnackBarがある場合は削除
    try {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    } catch (e) {
      // contextが無効な場合は無視
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "PopCal",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const GlassSnackbarContent(message: 'リストを更新しました'),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const DrawerScreen(),
      floatingActionButton: GlassmorphicContainer(
        width: 56,
        height: 56,
        borderRadius: 28,
        blur: 10,
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
            borderRadius: BorderRadius.circular(28),
            onTap: () => context.push(Routes.rotation),
            child: const Center(
              child: Icon(Icons.add, color: Colors.white, size: 24),
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(child: _buildContent()),
      ),
    );
  }

  Widget _buildContent() {
    // 空のリストを表示したい場合は以下をコメントアウト
    // rotationGroups = [];

    if (rotationGroups.isEmpty) {
      return EmptyState(
        title: 'ローテーションがありません',
        description: '新しいローテーションを作成してみましょう',
        icon: Icons.group_add,
        onAction: () => context.push(Routes.rotation),
        actionText: '作成',
      );
    }

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final rotationGroup = rotationGroups[index];
              return RotationListItem(
                rotationGroup: rotationGroup,
                onTap: () {
                  // ログ出力のみ
                  print('タップされました: ${rotationGroup.rotationName}');
                },
                onDelete: () {
                  final deletedGroup = rotationGroup;
                  final deletedIndex = index;

                  // ScaffoldMessengerの参照を事前に取得
                  final scaffoldMessenger = ScaffoldMessenger.of(context);

                  setState(() {
                    rotationGroups.removeWhere(
                      (group) =>
                          group.rotationGroupId ==
                          rotationGroup.rotationGroupId,
                    );
                  });

                  scaffoldMessenger.hideCurrentSnackBar();
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: GlassSnackbarContentWithAction(
                        message: '${deletedGroup.rotationName}を削除しました',
                        onAction: () {
                          try {
                            // contextが有効かどうかをチェック
                            if (mounted) {
                              scaffoldMessenger.hideCurrentSnackBar();
                              setState(() {
                                rotationGroups.insert(
                                  deletedIndex,
                                  deletedGroup,
                                );
                              });
                            }
                          } catch (e) {
                            // エラーが発生した場合はログに出力（デバッグ時のみ）
                            debugPrint('SnackBar action error: $e');
                          }
                        },
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                },
              );
            }, childCount: rotationGroups.length),
          ),
        ),
      ],
    );
  }
}
