import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/auth/presentation/screens/login_screen.dart';
import 'package:popcal/features/auth/providers/auth_stream.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/features/home/presentation/widgets/glass_list_item.dart';
import 'package:popcal/features/notifications/providers/notification_providers.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/providers/rotation_notifier.dart';
import 'package:popcal/features/rotation/providers/rotation_providers.dart';
import 'package:popcal/features/rotation/providers/rotation_stream.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/screens/custom_error_screen.dart';
import 'package:popcal/shared/screens/custom_error_simple_screen.dart';
import 'package:popcal/shared/screens/custom_loading_screen.dart';
import 'package:popcal/shared/screens/custom_loading_simple_screen.dart';
import 'package:popcal/shared/utils/snackbar_utils.dart';
import 'package:popcal/shared/widgets/glass_app_bar/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});

  final Logger logger = Logger('HomeScreen');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // 全画面で動作するため注意 ※3.0以降は別画面に遷移するとpauseするようになる
    ref.listen(rotationNotifierProvider, (previousValue, newValue) {
      // Home画面の場合のみ処理を実行
      if (ModalRoute.of(context)?.isCurrent ?? true) {
        newValue.when(
          data: (result) {
            if (result == null) return;
            if (result.isFailure) {
              SnackBarUtils.showGlassSnackBar(
                textTheme: textTheme,
                glassTheme: glassTheme,
                scaffoldMessenger: scaffoldMessenger,
                flexibleMessage: '復元に失敗しました: ${result.failureOrNull}',
              );
            }
            if (previousValue?.isLoading ?? false) {
              SnackBarUtils.showGlassSnackBar(
                textTheme: textTheme,
                glassTheme: glassTheme,
                scaffoldMessenger: scaffoldMessenger,
                flexibleMessage: result.valueOrNull!.rotationName.value,
                fixedMessage: 'を復元しました',
              );
            }
          },
          error: (error, _) {
            if (previousValue?.isLoading ?? false) {
              SnackBarUtils.showGlassSnackBar(
                textTheme: textTheme,
                glassTheme: glassTheme,
                scaffoldMessenger: scaffoldMessenger,
                flexibleMessage: '復元に失敗しました: $error',
              );
            }
          },
          loading: () => null,
        );
      }
    });

    // 通知タップから起動した場合の画面遷移 (calendar screenに遷移)
    useEffect(() {
      // useEffect内はref.watchは使用不可
      ref.read(notificationGatewayProvider).initializeNotificationLaunch();
      return null;
    }, []);

    // ユーザ情報取得
    final authState = ref.watch(authStateChangesForUIProvider);
    return authState.when(
      data:
          (dtoResult) => dtoResult.when(
            success: (dto) {
              if (dto == null) return const LoginScreen();

              // バックグラウンドで通知同期処理
              useEffect(() {
                ref.read(syncNotificationsUseCaseProvider).execute(dto.userId);
                return null;
              }, [dto.userId]);

              return _buildHome(context, ref, dto);
            },
            failure: (error) {
              return CustomErrorScreen(message: error.message);
            },
          ),
      loading: CustomLoadingScreen.new,
      error: (error, stack) => const CustomErrorScreen(),
    );
  }

  Widget _buildHome(BuildContext context, WidgetRef ref, UserResponse dto) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final rotationResponsesStream = ref.watch(
      rotationResponsesStreamProvider(dto.userId),
    );

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: const GlassAppBar(title: 'PopCal'),
      drawer: const DrawerScreen(),
      floatingActionButton: GlassButton(
        width: 56,
        height: 56,
        iconData: Icons.add,
        onPressed: () => const RotationCreateRoute().push<void>(context),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          // ローテーショングループ一覧表示 (StreamBuilderと同じ)
          child: rotationResponsesStream.when(
            data:
                (result) => result.when(
                  success:
                      (rotationResponses) =>
                          rotationResponses.isEmpty
                              ? _buildRotationEmpty(context)
                              : _buildRotations(
                                context,
                                ref,
                                dto,
                                rotationResponses,
                              ),
                  failure:
                      (error) => CustomErrorSimpleScreen(
                        message: error.message,
                      ),
                ),
            loading: CustomLoadingSimpleScreen.new,
            error:
                (error, stack) => CustomErrorSimpleScreen(
                  message: error.toString(),
                ),
          ),
        ),
      ),
    );
  }

  // ローテーショングループが1つもない場合
  Widget _buildRotationEmpty(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: GlassWrapper(
        width: 340,
        height: 240,
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            const GlassIcon(iconData: Icons.group_add),
            // Text1
            Text(
              'ローテーションがありません',
              style: textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            // Text2
            Text(
              '新しいローテーションを作成してみましょう',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            // 作成Button
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GlassButton(
                width: 120,
                height: 40,
                text: '作成',
                onPressed:
                    () => const RotationCreateRoute().push<void>(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ローテーショングループを一覧表示
  Widget _buildRotations(
    BuildContext context,
    WidgetRef ref,
    UserResponse userDto,
    List<RotationResponse> rotationResponses,
  ) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
              final rotationResponse = rotationResponses[index];
              return GlassListItem(
                rotationResponse: rotationResponse,
                onTap: () => _onTapRotation(context, rotationResponse),
                onEdit: () => _onEditRotation(context, rotationResponse),
                onDelete:
                    () =>
                        _handleDelete(context, ref, rotationResponse, userDto),
              );
            }, childCount: rotationResponses.length),
          ),
        ),
      ],
    );
  }

  // ローテーショングループの削除&復元処理
  Future<void> _handleDelete(
    BuildContext context,
    WidgetRef ref,
    RotationResponse rotationResponse,
    UserResponse userDto,
  ) async {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final rotationRepository = ref.read(rotationRepositoryProvider);

    // 削除処理
    final result = await rotationRepository.deleteRotation(
      userDto.userId,
      rotationResponse.rotationId,
    );

    result.when(
      success: (_) {
        SnackBarUtils.showGlassSnackBarWithAction(
          textTheme: textTheme,
          glassTheme: glassTheme,
          scaffoldMessenger: scaffoldMessenger,
          flexibleMessage: rotationResponse.rotationName.value,
          fixedMessage: 'を削除しました',
          onAction:
              () => _handleRestore(
                ref,
                rotationResponse,
              ),
          actionLabel: '元に戻す',
        );
      },
      failure: (error) {
        SnackBarUtils.showGlassSnackBar(
          textTheme: textTheme,
          glassTheme: glassTheme,
          scaffoldMessenger: scaffoldMessenger,
          flexibleMessage: '削除に失敗しました',
        );
      },
    );
  }

  Future<void> _handleRestore(
    WidgetRef ref,
    RotationResponse rotationResponse,
  ) async {
    final createDto = CreateRotationRequest(
      userId: rotationResponse.userId,
      rotationName: rotationResponse.rotationName,
      rotationMembers: rotationResponse.rotationMembers,
      rotationDays: rotationResponse.rotationDays,
      notificationTime: rotationResponse.notificationTime,
      skipEvents: rotationResponse.skipEvents,
    );

    final rotationController = ref.read(rotationNotifierProvider.notifier);
    await rotationController.createRotation(createDto);
  }

  void _onEditRotation(
    BuildContext context,
    RotationResponse rotationResponse,
  ) {
    RotationUpdateRoute(
      id: rotationResponse.rotationId.value,
    ).push<void>(context);
  }

  void _onTapRotation(BuildContext context, RotationResponse rotationResponse) {
    CalendarRoute(
      id: rotationResponse.rotationId.value,
    ).push<void>(context);
  }
}
