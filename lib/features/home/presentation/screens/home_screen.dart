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
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/glass_snackbar_content.dart';
import 'package:popcal/shared/widgets/glass_snackbar_content_with_action.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(homeViewModelProvider).isLoading;
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
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

    useEffect(
      () {
        // マウント時の処理 (init相当)

        // リターンでクリーンアップ関数を返す（dispose相当）
        return () {
          // SnackBarがある場合は削除
          try {
            if (context.mounted) {
              // mountedの代わりにcontext.mountedを使用
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
          } catch (e) {
            // contextが無効な場合は無視
            debugPrint('SnackBar削除エラー: $e');
          }
        };
      },
      [], // 空の配列で初回マウント時とアンマウント時のみ実行
    );

    Future<void> handleManualGetRotationGroups() async {
      if (currentUser == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('ログインが必要です')));
        }
        return;
      }

      // Stream再実行
      ref.invalidate(rotationGroupsStreamProvider(currentUser.uid));

      // final result = await homeViewModel.getRotationGroups(currentUser.uid);
      // if (result.isSuccess) {
      //   rotationGroups.value = result.valueOrNull!;
      // }

      // async非同期関数では、context.mountedをチェックする
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
                onPressed: null, // 無効化
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
                onPressed: () async {
                  await handleManualGetRotationGroups();
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
        child: SafeArea(
          child: rotationGroupsStream.when(
            data:
                (result) => result.when(
                  success:
                      (rotationGroups) =>
                          _buildContent(context, rotationGroups),
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
    List<RotationGroup> rotationGroups,
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
                  // ログ出力のみ
                  print('タップされました: ${rotationGroup.rotationName}');
                },
                onDelete: () {
                  final deletedGroup = rotationGroup;
                  final deletedIndex = index;

                  // ScaffoldMessengerの参照を事前に取得
                  final scaffoldMessenger = ScaffoldMessenger.of(context);

                  // setStateの代わりにValueNotifierの値を更新
                  rotationGroups = List.from(rotationGroups)..removeWhere(
                    (group) =>
                        group.rotationGroupId == rotationGroup.rotationGroupId,
                  );

                  scaffoldMessenger.hideCurrentSnackBar();
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: GlassSnackbarContentWithAction(
                        message: '${deletedGroup.rotationName}を削除しました',
                        onAction: () {
                          try {
                            // context.mountedを使用（mountedの代わり）
                            if (context.mounted) {
                              scaffoldMessenger.hideCurrentSnackBar();
                              // 元に戻す処理
                              rotationGroups = List.from(rotationGroups)
                                ..insert(deletedIndex, deletedGroup);
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
