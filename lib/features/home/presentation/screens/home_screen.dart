// lib/features/home/presentation/screens/home_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/providers/user_provider.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/home/presentation/widgets/empty_state.dart';
import 'package:popcal/features/home/presentation/widgets/rotation_list_item.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/glass_snackbar_content.dart';
import 'package:popcal/shared/widgets/glass_snackbar_content_with_action.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationProvider = ref.watch(notificationRepositoryProvider);
    final syncUseCase = ref.watch(syncNotificationsUseCaseProvider);
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

    // 削除されたアイテムを一時的に保持するstate
    final deletedItem = useState<RotationGroup?>(null);

    // 通知タップから起動した場合の画面遷移
    useEffect(() {
      () async {
        final result =
            await notificationProvider.initializeNotificationLaunch();
      }();
    }, []);

    // 🔥 通知同期処理
    useEffect(() {
      // ログ出力
      notificationProvider.logPendingNotifications();
      if (currentUser != null) {
        () async {
          final result = await syncUseCase.execute(currentUser.uid);
          result.when(
            success: (_) {
              print('通知同期が完了しました');
            },
            failure: (error) {
              print('通知同期に失敗しました: $error');
            },
          );
        }();
      }
      return null;
    }, [currentUser?.uid]);

    final isLoading = rotationGroupsStream.isLoading;

    Future<void> handleManualRefresh() async {
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      if (currentUser == null) {
        scaffoldMessenger.clearSnackBars();
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: GlassSnackbarContent(message: 'ログインが必要です'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }

      ref.invalidate(rotationGroupsStreamProvider(currentUser.uid));

      () async {
        final result = await syncUseCase.execute(currentUser.uid);
        result.when(
          success: (_) {
            print('通知同期が完了しました');
          },
          failure: (error) {
            print('通知同期に失敗しました: $error');
          },
        );
      }();

      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
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
                        deletedItem,
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
    AppUser? currentUser,
    ValueNotifier<RotationGroup?> deletedItem,
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
                  context.push(
                    Routes.rotationUpdatePath(rotationGroup.rotationGroupId!),
                  );
                },
                onDelete:
                    () => _handleDelete(
                      context,
                      ref,
                      rotationGroup,
                      currentUser,
                      deletedItem,
                    ),
              );
            }, childCount: rotationGroups.length),
          ),
        ),
      ],
    );
  }

  void _handleDelete(
    BuildContext context,
    WidgetRef ref,
    RotationGroup rotationGroup,
    AppUser? currentUser,
    ValueNotifier<RotationGroup?> deletedItem,
  ) async {
    if (currentUser == null || rotationGroup.rotationGroupId == null) {
      return;
    }

    // ScaffoldMessengerを事前に取得
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // 削除したアイテムを保持
    deletedItem.value = rotationGroup;

    // 削除処理を実行
    try {
      final rotationRepository = ref.read(rotationRepositoryProvider);
      await rotationRepository.deleteRotationGroup(
        currentUser.uid,
        rotationGroup.rotationGroupId!,
      );

      // 事前に取得したScaffoldMessengerを使用
      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: GlassSnackbarContentWithAction(
            message: '${rotationGroup.rotationName}を削除しました',
            onAction:
                () => _handleRestore(
                  scaffoldMessenger, // ScaffoldMessengerを渡す
                  ref,
                  currentUser,
                  deletedItem,
                ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 5),
        ),
      );
    } catch (e) {
      deletedItem.value = null;
      scaffoldMessenger.showSnackBar(
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

  void _handleRestore(
    ScaffoldMessengerState
    scaffoldMessenger, // contextの代わりにScaffoldMessengerを受け取る
    WidgetRef ref,
    AppUser currentUser,
    ValueNotifier<RotationGroup?> deletedItem,
  ) async {
    final itemToRestore = deletedItem.value;
    if (itemToRestore == null) return;

    try {
      // 削除したアイテムを再作成
      final createUseCase = ref.read(createRotationGroupUseCaseProvider);

      // rotationGroupIdをnullにして新規作成として扱う
      final rotationGroupToCreate = itemToRestore.copyWith(
        rotationGroupId: null,
        createdAt: DateTime.now().toLocal(),
        updatedAt: DateTime.now().toLocal(),
      );

      final result = await createUseCase.execute(rotationGroupToCreate);

      result.when(
        success: (_) {
          // 復元成功
          deletedItem.value = null;
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: GlassSnackbarContent(
                message: '${itemToRestore.rotationName}を復元しました',
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
          // 復元失敗
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: GlassSnackbarContent(message: '復元に失敗しました: $error'),
              backgroundColor: Colors.transparent,
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
              duration: const Duration(seconds: 3),
            ),
          );
        },
      );
    } catch (e) {
      // 復元失敗
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: GlassSnackbarContent(message: '復元に失敗しました: $e'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
