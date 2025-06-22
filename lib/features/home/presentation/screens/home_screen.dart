// lib/features/home/presentation/screens/home_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/providers/user_provider.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/home/presentation/widgets/empty_state.dart';
import 'package:popcal/features/home/presentation/widgets/rotation_list_item.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
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

    // 削除予定のアイテムIDを管理
    final pendingDeleteIds = useState<Set<String>>({});
    // 削除タイマーを管理
    final deleteTimers = useRef<Map<String, Timer>>({});

    final isLoading = rotationGroupsStream.isLoading;

    useEffect(() {
      return () {
        // クリーンアップ：すべてのタイマーをキャンセル
        for (final timer in deleteTimers.value.values) {
          timer.cancel();
        }
        deleteTimers.value.clear();
      };
    }, []);

    Future<void> handleManualRefresh() async {
      if (currentUser == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: GlassSnackbarContent(message: 'ログインが必要です'),
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 2),
            ),
          );
        }
        return;
      }

      ref.invalidate(rotationGroupsStreamProvider(currentUser.uid));

      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
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
                        pendingDeleteIds,
                        deleteTimers,
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

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<RotationGroup> rotationGroups,
    currentUser,
    ValueNotifier<Set<String>> pendingDeleteIds,
    ObjectRef<Map<String, Timer>> deleteTimers,
  ) {
    // 削除予定のアイテムを除外してフィルタリング
    final filteredGroups =
        rotationGroups
            .where(
              (group) =>
                  !pendingDeleteIds.value.contains(group.rotationGroupId),
            )
            .toList();

    if (filteredGroups.isEmpty) {
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
              final rotationGroup = filteredGroups[index];
              return RotationListItem(
                rotationGroup: rotationGroup,
                onTap: () {
                  print('タップされました: ${rotationGroup.rotationName}');
                },
                onDelete:
                    () => _handleOptimisticDelete(
                      context,
                      ref,
                      rotationGroup,
                      currentUser,
                      pendingDeleteIds,
                      deleteTimers,
                    ),
              );
            }, childCount: filteredGroups.length),
          ),
        ),
      ],
    );
  }

  void _handleOptimisticDelete(
    BuildContext context,
    WidgetRef ref,
    RotationGroup rotationGroup,
    currentUser,
    ValueNotifier<Set<String>> pendingDeleteIds,
    ObjectRef<Map<String, Timer>> deleteTimers,
  ) {
    if (currentUser == null || rotationGroup.rotationGroupId == null) {
      return;
    }

    final itemId = rotationGroup.rotationGroupId!;

    // 1. UIから即座に削除（ローカルstateで管理）
    pendingDeleteIds.value = {...pendingDeleteIds.value, itemId};

    // 2. SnackBar表示
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GlassSnackbarContentWithAction(
          message: '${rotationGroup.rotationName}を削除します',
          onAction: () {
            _cancelDelete(context, itemId, pendingDeleteIds, deleteTimers);
          },
          actionLabel: '元に戻す',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 5),
      ),
    );

    // 3. SnackBarが消えるタイミングで実削除を実行
    final timer = Timer(const Duration(seconds: 5), () async {
      // タイマーマップから削除
      deleteTimers.value.remove(itemId);

      // 実際の削除を実行
      try {
        final rotationRepository = ref.read(rotationRepositoryProvider);
        await rotationRepository.deleteRotationGroup(currentUser.uid, itemId);

        // 削除予定リストからも除外
        pendingDeleteIds.value =
            pendingDeleteIds.value.where((id) => id != itemId).toSet();
      } catch (e) {
        // 削除失敗時は元に戻す
        _cancelDelete(context, itemId, pendingDeleteIds, deleteTimers);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: GlassSnackbarContent(message: '削除に失敗しました: $e'),
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    });

    // タイマーを保存
    deleteTimers.value[itemId] = timer;
  }

  void _cancelDelete(
    BuildContext context,
    String itemId,
    ValueNotifier<Set<String>> pendingDeleteIds,
    ObjectRef<Map<String, Timer>> deleteTimers,
  ) {
    // タイマーをキャンセル
    deleteTimers.value[itemId]?.cancel();
    deleteTimers.value.remove(itemId);

    // UIを元に戻す
    pendingDeleteIds.value =
        pendingDeleteIds.value.where((id) => id != itemId).toSet();

    // SnackBarクリアは既にonActionで実行済み
  }
}
