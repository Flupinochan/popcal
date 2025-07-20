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
import 'package:popcal/features/home/presentation/view_models/home_view_model.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/utils/snackbar_utils.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationProvider = ref.watch(notificationRepositoryProvider);
    final syncUseCase = ref.watch(syncNotificationsUseCaseProvider);
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

    // 削除されたアイテムを一時的に保持するstate
    final deletedItem = useState<RotationGroup?>(null);

    // 通知タップから起動した場合の画面遷移
    useEffect(() {
      () async {
        await notificationProvider.initializeNotificationLaunch();
      }();
      return null;
    }, []);

    // 🔥 通知同期処理
    useEffect(() {
      notificationProvider.logPendingNotifications();
      if (currentUser != null) {
        () async {
          await syncUseCase.execute(currentUser.uid);
        }();
      }
      return null;
    }, [currentUser?.uid]);

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
                        homeViewModel,
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
    HomeViewModel homeViewModel,
  ) {
    if (rotationGroups.isEmpty) {
      return EmptyState();
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
                    Routes.calendarPath(rotationGroup.rotationGroupId!),
                  );
                },
                onEdit: () {
                  context.push(
                    Routes.rotationUpdatePath(rotationGroup.rotationGroupId!),
                  );
                },
                onDelete:
                    () => _handleDelete(
                      context,
                      rotationGroup,
                      currentUser,
                      deletedItem,
                      homeViewModel,
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
    RotationGroup rotationGroup,
    AppUser? currentUser,
    ValueNotifier<RotationGroup?> deletedItem,
    HomeViewModel homeViewModel,
  ) async {
    if (currentUser == null || rotationGroup.rotationGroupId == null) {
      return;
    }

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    deletedItem.value = rotationGroup;

    final result = await homeViewModel.deleteRotationGroup(
      currentUser.uid,
      rotationGroup.rotationGroupId!,
    );

    result.when(
      success: (_) {
        SnackBarUtils.showGlassSnackBarWithAction(
          scaffoldMessenger,
          '${rotationGroup.rotationName}を削除しました',
          onAction:
              () => _handleRestore(
                scaffoldMessenger,
                rotationGroup,
                deletedItem,
                homeViewModel,
              ),
        );
      },
      failure: (error) {
        deletedItem.value = null;
        SnackBarUtils.showGlassSnackBar(scaffoldMessenger, '削除に失敗しました: $error');
      },
    );
  }

  void _handleRestore(
    ScaffoldMessengerState scaffoldMessenger,
    RotationGroup rotationGroup,
    ValueNotifier<RotationGroup?> deletedItem,
    HomeViewModel homeViewModel,
  ) async {
    final result = await homeViewModel.restoreRotationGroup(rotationGroup);

    result.when(
      success: (_) {
        deletedItem.value = null;
        SnackBarUtils.showGlassSnackBar(
          scaffoldMessenger,
          '${rotationGroup.rotationName}を復元しました',
        );
      },
      failure: (error) {
        SnackBarUtils.showGlassSnackBar(scaffoldMessenger, '復元に失敗しました: $error');
      },
    );
  }
}
