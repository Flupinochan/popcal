import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/providers/user_provider.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/home/presentation/view_models/home_view_model.dart';
import 'package:popcal/features/home/presentation/widgets/empty_state.dart';
import 'package:popcal/features/home/presentation/widgets/rotation_list_item.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/presentation/view_models/rotation_view_model.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/glass_snackbar_content.dart';
import 'package:popcal/shared/widgets/glass_snackbar_content_with_action.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserState = ref.watch(currentUserProvider);
    final currentUser = currentUserState.when(
      data:
          (result) =>
              result.when(success: (user) => user, failure: (_) => null),
      loading: () => null,
      error: (_, __) => null,
    );

    final rotationGroupsStream =
        currentUser != null
            ? ref.watch(rotationGroupsStreamProvider(currentUser.uid))
            : AsyncValue<Result<List<RotationGroup>>>.data(
              Results.failure<List<RotationGroup>>(AuthFailure('未認証です')),
            );

    final isLoading = rotationGroupsStream.isLoading;

    useEffect(() {
      return () {
        try {
          if (context.mounted) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          }
        } catch (e) {
          debugPrint('SnackBar削除エラー: $e');
        }
      };
    }, []);

    Future<void> handleManualRefresh() async {
      if (currentUser == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('ログインが必要です')));
        }
        return;
      }

      ref.invalidate(rotationGroupsStreamProvider(currentUser.uid));

      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: GlassSnackbarContent(message: 'リストを更新しました'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }

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
          isLoading
              ? IconButton(
                onPressed: null,
                icon: SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              )
              : IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: handleManualRefresh,
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
        child: SafeArea(
          child: rotationGroupsStream.when(
            data:
                (result) => result.when(
                  success:
                      (rotationGroups) => _buildContent(
                        context,
                        ref,
                        rotationGroups,
                        currentUser,
                      ),
                  failure:
                      (error) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'データの取得に失敗しました',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              error.toString(),
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                ),
            loading:
                () => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
            error:
                (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'エラーが発生しました',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }

  // RotationGroups取得成功時のUI
  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<RotationGroup> rotationGroups,
    currentUser,
  ) {
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
                  print('タップされました: ${rotationGroup.rotationName}');
                },
                onDelete:
                    () => _handleDeleteRotationGroup(
                      context,
                      ref,
                      rotationGroup,
                      currentUser,
                    ),
              );
            }, childCount: rotationGroups.length),
          ),
        ),
      ],
    );
  }

  // 即座削除 + 元に戻す（再作成）パターン
  Future<void> _handleDeleteRotationGroup(
    BuildContext context,
    WidgetRef ref,
    RotationGroup rotationGroup,
    currentUser,
  ) async {
    if (currentUser == null || rotationGroup.rotationGroupId == null) {
      return;
    }

    // 削除前のデータを保存
    final deletedItem = rotationGroup;

    // 即座にFirebaseから削除
    final result = await ref
        .read(homeViewModelProvider.notifier)
        .deleteRotationGroup(currentUser.uid, rotationGroup.rotationGroupId!);

    if (context.mounted) {
      result.when(
        success: (_) {
          // 削除成功時に元に戻すボタン付きSnackBarを表示
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: GlassSnackbarContentWithAction(
                message: '${deletedItem.rotationName}を削除しました',
                onAction:
                    () => _restoreRotationGroup(context, ref, deletedItem),
                actionLabel: '元に戻す',
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 5),
            ),
          );
        },
        failure: (error) {
          // 削除失敗時のエラー表示
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: GlassSnackbarContent(
                message: '削除に失敗しました: ${error.toString()}',
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 3),
            ),
          );
        },
      );
    }
  }

  // 削除されたアイテムを再作成して復元
  Future<void> _restoreRotationGroup(
    BuildContext context,
    WidgetRef ref,
    RotationGroup deletedItem,
  ) async {
    // 新しいローテーショングループとして再作成
    final restoredItem = RotationGroup(
      rotationGroupId: null,
      ownerUserId: deletedItem.ownerUserId,
      rotationName: deletedItem.rotationName,
      rotationMembers: deletedItem.rotationMembers,
      notificationTime: deletedItem.notificationTime,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final result = await ref
        .read(rotationViewModelProvider.notifier)
        .createRotationGroup(restoredItem);

    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      result.when(
        success: (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: GlassSnackbarContent(
                message: '${deletedItem.rotationName}を復元しました',
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        failure: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: GlassSnackbarContent(
                message: '復元に失敗しました: ${error.toString()}',
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 3),
            ),
          );
        },
      );
    }
  }
}
