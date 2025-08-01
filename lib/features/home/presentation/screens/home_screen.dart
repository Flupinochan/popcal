import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/presentation/screens/auth_screen.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/home/presentation/screens/home_screen_empty.dart';
import 'package:popcal/features/home/presentation/widgets/glass_list_item.dart';
import 'package:popcal/features/home/providers/home_view_model.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/screen/error_screen.dart';
import 'package:popcal/shared/screen/loading_screen.dart';
import 'package:popcal/shared/utils/snackbar_utils.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/loading_widget.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});

  final Logger logger = Logger("HomeScreen");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 通知タップから起動した場合の画面遷移 (calendar screenに遷移)
    final notificationProvider = ref.watch(notificationRepositoryProvider);
    useEffect(() {
      notificationProvider.initializeNotificationLaunch();
      return null;
    }, []);

    // ユーザ情報取得
    final authState = ref.watch(authStateChangesProvider);
    return authState.when(
      data:
          (authResult) => authResult.when(
            success: (user) {
              if (user == null) return LoginScreen();

              // 通知同期処理
              useEffect(() {
                final syncUseCase = ref.watch(syncNotificationsUseCaseProvider);
                syncUseCase.execute(user.uid);
                return null;
              }, [user.uid]);

              return _buildHomeScreen(context, ref, user);
            },
            failure: (error) => ErrorScreen(message: error.message),
          ),
      loading: () => LoadingScreen(),
      error: (error, stack) => ErrorScreen(message: error.toString()),
    );
  }

  Widget _buildHomeScreen(BuildContext context, WidgetRef ref, AppUser user) {
    final rotationGroupsAsync = ref.watch(
      rotationGroupsStreamProvider(user.uid),
    );
    final glassTheme = Theme.of(context).extension<GlassTheme>()!;

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
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
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          // ローテーショングループ一覧表示
          child: rotationGroupsAsync.when(
            data:
                (result) => result.when(
                  success:
                      (rotationGroups) =>
                          rotationGroups.isEmpty
                              ? HomeScreenEmpty()
                              : _buildRotationGroupList(
                                context,
                                ref,
                                user,
                                rotationGroups,
                              ),
                  failure: (error) => ErrorScreen(message: error.message),
                ),
            loading: () => LoadingWidget(),
            error: (error, stack) => ErrorWidget(error.toString()),
          ),
        ),
      ),
    );
  }

  Widget _buildRotationGroupList(
    BuildContext context,
    WidgetRef ref,
    AppUser user,
    List<RotationGroup> rotationGroups,
  ) {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
    final deletedItem = useState<RotationGroup?>(null);

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
                      user,
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

  // ローテーショングループの削除処理&復元処理
  void _handleDelete(
    BuildContext context,
    RotationGroup rotationGroup,
    AppUser currentUser,
    ValueNotifier<RotationGroup?> deletedItem,
    HomeViewModel homeViewModel,
  ) async {
    deletedItem.value = rotationGroup;

    final result = await homeViewModel.deleteRotationGroup(
      currentUser.uid,
      rotationGroup.rotationGroupId!,
    );

    result.when(
      success: (_) {
        SnackBarUtils.showGlassSnackBarWithAction(
          context: context,
          message: '${rotationGroup.rotationName}を削除しました',
          onAction: () async {
            // Restore
            final result = await homeViewModel.restoreRotationGroup(
              rotationGroup,
            );
            result.when(
              success: (_) {
                deletedItem.value = null;
                SnackBarUtils.showGlassSnackBar(
                  context: context,
                  message: '${rotationGroup.rotationName}を元に戻しました',
                );
              },
              failure: (error) {
                SnackBarUtils.showGlassSnackBar(
                  context: context,
                  message: '復元に失敗しました: $error',
                );
              },
            );
          },
          actionLabel: '元に戻す',
        );
      },
      failure: (error) {
        deletedItem.value = null;
        SnackBarUtils.showGlassSnackBar(
          context: context,
          message: '削除に失敗しました: $error',
        );
      },
    );
  }
}
