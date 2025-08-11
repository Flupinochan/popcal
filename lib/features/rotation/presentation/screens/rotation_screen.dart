import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_bottom_action_bar.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_list.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_time.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_weekday.dart';
import 'package:popcal/features/rotation/providers/rotation_loader.dart';
import 'package:popcal/features/rotation/providers/rotation_notifier.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/utils/snackbar_utils.dart';
import 'package:popcal/shared/widgets/custom_error_screen.dart';
import 'package:popcal/shared/widgets/custom_loading_screen.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_form_text.dart';

Future<void> _handleSubmit(
  BuildContext context,
  WidgetRef ref,
  GlobalKey<FormBuilderState> formKey,
  UserResponse userDto,
  RotationResponse? originalRotation,
  bool isUpdateMode,
) async {
  final textTheme = Theme.of(context).textTheme;
  final glassTheme =
      Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  if (formKey.currentState!.saveAndValidate()) {
    final formData = formKey.currentState!.value;
    final rotationController = ref.read(rotationNotifierProvider.notifier);

    try {
      if (isUpdateMode) {
        final dto = UpdateRotationRequest(
          userId: userDto.userId,
          rotationId: originalRotation!.rotationId,
          rotationName: RotationName(formData['rotationName'] as String),
          rotationMembers: List<RotationMemberName>.from(
            formData['rotationMembers'] as List,
          ),
          rotationDays: formData['rotationDays'] as List<Weekday>,
          notificationTime: NotificationTime(
            formData['notificationTime'] as TimeOfDay,
          ),
          createdAt: originalRotation.createdAt,
        );
        await rotationController.updateRotation(dto);
      } else {
        final dto = CreateRotationRequest(
          userId: userDto.userId,
          rotationName: RotationName(formData['rotationName'] as String),
          rotationMembers: List<RotationMemberName>.from(
            formData['rotationMembers'] as List,
          ),
          rotationDays: formData['rotationDays'] as List<Weekday>,
          notificationTime: NotificationTime(
            formData['notificationTime'] as TimeOfDay,
          ),
        );
        await rotationController.createRotation(dto);
      }

      if (context.mounted) {
        SnackBarUtils.showGlassSnackBar(
          textTheme: textTheme,
          glassTheme: glassTheme,
          scaffoldMessenger: scaffoldMessenger,
          flexibleMessage: formData['rotationName'].toString(),
          fixedMessage: isUpdateMode ? 'を更新しました' : 'を作成しました',
        );
        context.pop();
      }
    } catch (error) {
      if (context.mounted) {
        SnackBarUtils.showGlassSnackBar(
          textTheme: textTheme,
          glassTheme: glassTheme,
          scaffoldMessenger: scaffoldMessenger,
          flexibleMessage: 'エラーが発生しました',
        );
      }
    }
  }
}

class RotationScreen extends HookConsumerWidget {
  const RotationScreen({super.key, this.rotationId});
  final RotationId? rotationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rotationDataAsync = ref.watch(
      rotationDataResponseProvider(rotationId),
    );

    return rotationDataAsync.when(
      data:
          (result) => result.when(
            success:
                (rotationData) => _buildFormScreen(context, ref, rotationData),
            failure: (error) => CustomErrorScreen(message: error.message),
          ),
      loading: CustomLoadingScreen.new,
      error: (error, stack) => const CustomErrorScreen(),
    );
  }

  Widget _buildFormScreen(
    BuildContext context,
    WidgetRef ref,
    RotationDataResponse rotationData,
  ) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final textTheme = Theme.of(context).textTheme;
    final isUpdateMode = rotationData.rotationResponse != null;
    final initialRotation = rotationData.rotationResponse;
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final isLoading = ref.watch(rotationNotifierProvider).isLoading;
    final timeUtils = ref.watch(timeUtilsProvider);
    final now = timeUtils.now();

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: GlassAppBar(
        title: isUpdateMode ? 'ローテーションを編集' : 'ローテーションを追加',
        leadingIcon: Icons.close,
        onLeadingPressed: () => context.pop(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          child: FormBuilder(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ローテーション名
                  Text('ローテーション名', style: textTheme.titleLarge),
                  // ローテーション名を入力
                  GlassFormText(
                    name: 'rotationName',
                    initialValue: initialRotation?.rotationName.value,
                    hintText: 'ローテーション名を入力',
                    validator: FormBuilderValidators.required(
                      errorText: 'ローテーション名を入力してください',
                    ),
                  ),
                  // メンバー名を入力
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: GlassFormList(
                      name: 'rotationMembers',
                      hintText: 'メンバー名を入力',
                      initialValue:
                          initialRotation?.rotationMembers
                              .map((member) => member.value)
                              .toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'メンバーを1つ以上追加してください';
                        }
                        return null;
                      },
                    ),
                  ),
                  // ローテーション曜日
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('ローテーション曜日', style: textTheme.titleMedium),
                  ),
                  GlassFormWeekday(
                    initialValue: initialRotation?.rotationDays,
                    now: now,
                  ),
                  // 通知時刻
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('通知時刻', style: textTheme.titleMedium),
                  ),
                  GlassFormTime(
                    initialValue: initialRotation?.notificationTime.value,
                    now: now,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // キャンセル/作成
      bottomNavigationBar: GlassBottomActionBar(
        isLoading: isLoading,
        isUpdateMode: isUpdateMode,
        onCancel: () => context.pop(),
        onSubmit:
            () => _handleSubmit(
              context,
              ref,
              formKey,
              rotationData.userDto,
              initialRotation,
              isUpdateMode,
            ),
      ),
    );
  }
}
