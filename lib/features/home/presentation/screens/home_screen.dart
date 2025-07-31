import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/home/presentation/screens/home_screen_empty.dart';
import 'package:popcal/features/home/presentation/widgets/glass_list_item.dart';
import 'package:popcal/features/home/providers/home_data_provider.dart';
import 'package:popcal/features/home/providers/home_view_model.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/screen/error_screen.dart';
import 'package:popcal/shared/utils/snackbar_utils.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/loading_widget.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});

  final Logger logger = Logger("HomeScreen");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationProvider = ref.watch(notificationRepositoryProvider);
    final homeDataAsync = ref.watch(homeDataProvider);
    final deletedItem = useState<RotationGroup?>(null);

    // 通知タップから起動した場合の画面遷移 (calendar screenに遷移)
    useEffect(() {
      notificationProvider.initializeNotificationLaunch();
      return null;
    }, []);

    return homeDataAsync.when(
      data:
          (result) => result.when(
            success:
                (homeData) =>
                    _buildHomeScreen(context, ref, homeData, deletedItem),
            failure: (error) => ErrorScreen(message: error.message),
          ),
      loading: () => LoadingWidget(),
      error: (error, stack) => ErrorScreen(message: error.toString()),
    );
  }

  Widget _buildHomeScreen(
    BuildContext context,
    WidgetRef ref,
    HomeData homeData,
    ValueNotifier<RotationGroup?> deletedItem,
  ) {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
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
          child:
              homeData.rotationGroups.isEmpty
                  ? HomeScreenEmpty()
                  : CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final rotationGroup =
                                homeData.rotationGroups[index];
                            return GlassListItem(
                              rotationGroup: rotationGroup,
                              onTap: () {
                                context.push(
                                  Routes.calendarPath(
                                    rotationGroup.rotationGroupId!,
                                  ),
                                );
                              },
                              onEdit: () {
                                context.push(
                                  Routes.rotationUpdatePath(
                                    rotationGroup.rotationGroupId!,
                                  ),
                                );
                              },
                              onDelete:
                                  () => _handleDelete(
                                    context,
                                    rotationGroup,
                                    homeData.user,
                                    deletedItem,
                                    homeViewModel,
                                  ),
                            );
                          }, childCount: homeData.rotationGroups.length),
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }

  void _handleDelete(
    BuildContext context,
    RotationGroup rotationGroup,
    AppUser currentUser,
    ValueNotifier<RotationGroup?> deletedItem,
    HomeViewModel homeViewModel,
  ) async {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme = Theme.of(context).extension<GlassTheme>()!;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    deletedItem.value = rotationGroup;

    final result = await homeViewModel.deleteRotationGroup(
      currentUser.uid,
      rotationGroup.rotationGroupId!,
    );

    result.when(
      success: (_) {
        SnackBarUtils.showGlassSnackBarWithAction(
          textTheme: textTheme,
          glassTheme: glassTheme,
          scaffoldMessenger: scaffoldMessenger,
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
                  textTheme: textTheme,
                  glassTheme: glassTheme,
                  scaffoldMessenger: scaffoldMessenger,
                  message: '${rotationGroup.rotationName}を元に戻しました',
                );
              },
              failure: (error) {
                SnackBarUtils.showGlassSnackBar(
                  textTheme: textTheme,
                  glassTheme: glassTheme,
                  scaffoldMessenger: scaffoldMessenger,
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
          textTheme: textTheme,
          glassTheme: glassTheme,
          scaffoldMessenger: scaffoldMessenger,
          message: '削除に失敗しました: $error',
        );
      },
    );
  }
}
