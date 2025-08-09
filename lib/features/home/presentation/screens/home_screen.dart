import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/result.dart';
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
import 'package:popcal/shared/widgets/custom_error_widget.dart';
import 'package:popcal/shared/widgets/custom_loading_widget.dart';
import 'package:popcal/shared/utils/snackbar_utils.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});

  final Logger logger = Logger("HomeScreen");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 通知タップから起動した場合の画面遷移 (calendar screenに遷移)
    useEffect(() {
      // useEffect内はref.watchは使用不可
      final notificationProvider = ref.read(notificationGatewayProvider);
      notificationProvider.initializeNotificationLaunch();
      return null;
    }, []);

    // ユーザ情報取得
    final authState = ref.watch(authStateChangesForUIProvider);
    return authState.when(
      data:
          (dtoResult) => dtoResult.when(
            success: (dto) {
              if (dto == null) return LoginScreen();

              // バックグラウンドで通知同期処理
              useEffect(() {
                final syncUseCase = ref.read(syncNotificationsUseCaseProvider);
                syncUseCase.execute(dto.userId);
                return null;
              }, [dto.userId]);

              return _buildHome(context, ref, dto);
            },
            failure: (error) {
              return customErrorWidget(context, error.message);
            },
          ),
      loading: () => customLoadingWidget(context),
      error: (error, stack) => customErrorWidget(context, error.toString()),
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
                      (error) =>
                          customErrorSimpleWidget(context, error.message),
                ),
            loading: () => customLoadingSimpleWidget(context),
            error:
                (error, stack) =>
                    customErrorSimpleWidget(context, error.toString()),
          ),
        ),
      ),
    );
  }

  // ローテーショングループが1つもない場合
  Widget _buildRotationEmpty(BuildContext context) {
    return Center(
      child: GlassWrapper(
        width: 340,
        height: 240,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            GlassIcon(iconData: Icons.group_add),
            const SizedBox(height: 16),
            // Text1
            Text(
              'ローテーションがありません',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Text2
            Text(
              '新しいローテーションを作成してみましょう',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // 作成Button
            GlassButton(
              width: 120,
              height: 40,
              text: '作成',
              onPressed: () => context.push(Routes.rotation),
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
            // このcontextは使用しない ※ローカル内で扱うcontextの場合は使用してOK (scaffold messengerはNG)
            delegate: SliverChildBuilderDelegate((_, index) {
              final rotationResponse = rotationResponses[index];
              return GlassListItem(
                rotationResponse: rotationResponse,
                onTap: () {
                  context.push(
                    Routes.calendarPath(rotationResponse.rotationId),
                  );
                },
                onEdit: () {
                  context.push(
                    Routes.rotationUpdatePath(rotationResponse.rotationId),
                  );
                },
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
  void _handleDelete(
    BuildContext context,
    WidgetRef ref,
    RotationResponse rotationResponse,
    UserResponse userDto,
  ) async {
    final rotationRepository = ref.read(rotationRepositoryProvider);
    final rotationController = ref.read(rotationNotifierProvider.notifier);

    // 削除処理
    final result = await rotationRepository.deleteRotation(
      userDto.userId,
      rotationResponse.rotationId,
    );

    result.when(
      success: (_) {
        SnackBarUtils.showGlassSnackBarWithAction(
          context: context,
          flexibleMessage: rotationResponse.rotationName.value,
          fixedMessage: 'を削除しました',
          onAction: () async {
            // 再作成処理
            final createDto = CreateRotationRequest(
              userId: rotationResponse.userId,
              rotationName: rotationResponse.rotationName,
              rotationMembers: rotationResponse.rotationMembers,
              rotationDays: rotationResponse.rotationDays,
              notificationTime: rotationResponse.notificationTime,
            );

            final restoreResult = await rotationController.createRotation(
              createDto,
            );

            // _buildRotationEmpty から _buildRotations に戻る場合はcontextが異なるため戻れない
            // 以下のcontextが前の親のcontextのためエラー
            restoreResult.when(
              success: (_) {
                SnackBarUtils.showGlassSnackBar(
                  context: context,
                  flexibleMessage: rotationResponse.rotationName.value,
                  fixedMessage: 'を元に戻しました',
                );
              },
              failure: (error) {
                SnackBarUtils.showGlassSnackBar(
                  context: context,
                  flexibleMessage: '復元に失敗しました',
                );
              },
            );
          },
          actionLabel: '元に戻す',
        );
      },
      failure: (error) {
        SnackBarUtils.showGlassSnackBar(
          context: context,
          flexibleMessage: '削除に失敗しました',
        );
      },
    );
  }
}
