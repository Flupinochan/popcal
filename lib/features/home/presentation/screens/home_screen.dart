import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/providers/user_provider.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/home/presentation/screens/home_screen_empty.dart';
import 'package:popcal/features/home/presentation/widgets/glass_list_item.dart';
import 'package:popcal/features/home/presentation/view_models/home_view_model.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/utils/snackbar_utils.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_button.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});

  final Logger logger = Logger("HomeScreen");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
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

    // 通知タップから起動した場合の画面遷移 (calendar screenに遷移)
    useEffect(() {
      () async {
        await notificationProvider.initializeNotificationLaunch();
      }();
      return null;
    }, []);

    // 通知同期処理
    useEffect(() {
      () async {
        await notificationProvider.logPendingNotifications();
      }();
      if (currentUser != null) {
        () async {
          await syncUseCase.execute(currentUser.uid);
        }();
      }
      return null;
    }, [currentUser?.uid]);

    return Scaffold(
      backgroundColor: glass.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: 'PopCal'),
      drawer: const DrawerScreen(),
      floatingActionButton: GlassButton(
        width: 56,
        height: 56,
        iconData: Icons.add,
        onPressed: () => context.push(Routes.rotation),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glass.primaryGradient),
        child: SafeArea(
          child: rotationGroupsStream.when(
            data:
                (result) => result.when(
                  success:
                      (rotationGroups) =>
                          rotationGroups.isEmpty
                              ? HomeScreenEmpty()
                              : _buildHomeScreen(
                                context,
                                ref,
                                rotationGroups,
                                currentUser,
                                deletedItem,
                                homeViewModel,
                              ),
                  failure: (error) {
                    logger.severe('データ取得エラー: $error');
                    return _buildLoadingIndicator(glass, context);
                  },
                ),
            loading: () => _buildLoadingIndicator(glass, context),
            error: (error, stackTrace) {
              logger.severe('データ取得エラー: $error, $stackTrace');
              return _buildLoadingIndicator(glass, context);
            },
          ),
        ),
      ),
    );
  }

  /// ローディング画面
  Widget _buildLoadingIndicator(GlassTheme glass, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: glass.surfaceColor, strokeWidth: 3),
          const SizedBox(height: 16),
          Text('データを読み込み中...', style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }

  /// ローテーションが1つ以上ある場合の画面
  Widget _buildHomeScreen(
    BuildContext context,
    WidgetRef ref,
    List<RotationGroup> rotationGroups,
    AppUser? currentUser,
    ValueNotifier<RotationGroup?> deletedItem,
    HomeViewModel homeViewModel,
  ) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final rotationGroup = rotationGroups[index];
              return GlassListItem(
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
