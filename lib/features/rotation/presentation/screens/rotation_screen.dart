import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/providers/core_provider.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/rotation/domain/enums/weekday.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/providers/rotation_notifier.dart';
import 'package:popcal/features/rotation/providers/rotation_loader.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_bottom_action_bar.dart';
import 'package:popcal/shared/widgets/custom_error_widget.dart';
import 'package:popcal/shared/widgets/custom_loading_widget.dart';
import 'package:popcal/shared/utils/snackbar_utils.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_list.dart';
import 'package:popcal/shared/widgets/glass_form_text.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_time.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_weekday.dart';

class RotationScreen extends HookConsumerWidget {
  final RotationId? rotationId;

  const RotationScreen({super.key, this.rotationId});

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
            failure: (error) => customErrorWidget(context, error.message),
          ),
      loading: () => customLoadingWidget(context),
      error: (error, stack) => customErrorWidget(context, error.toString()),
    );
  }

  Widget _buildFormScreen(
    BuildContext context,
    WidgetRef ref,
    RotationDataResponse rotationData,
  ) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final isUpdateMode = rotationData.rotationResponse != null;
    final initialRotation = rotationData.rotationResponse;
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = ref.watch(rotationNotifierProvider).isLoading;
    final now = ref.watch(nowProvider);

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: GlassAppBar(
        title: isUpdateMode ? 'ローテーションを編集' : 'ローテーションを追加',
        leadingIcon: Icons.close,
        onLeadingPressed: () => Navigator.pop(context),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          child: FormBuilder(
            key: formKey,
            enabled: true,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ローテーション名
                  Text(
                    'ローテーション名',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  // ローテーション名を入力
                  GlassFormText(
                    name: 'rotationName',
                    initialValue: initialRotation?.rotationName.value,
                    hintText: 'ローテーション名を入力',
                    validator: FormBuilderValidators.required(
                      errorText: 'ローテーション名を入力してください',
                    ),
                  ),
                  const SizedBox(height: 24),
                  // メンバー名を入力
                  GlassFormList(
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
                  const SizedBox(height: 24),
                  // ローテーション曜日
                  Text(
                    'ローテーション曜日',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  GlassFormWeekday(
                    initialValue: initialRotation?.rotationDays,
                    now: now,
                  ),
                  const SizedBox(height: 24),
                  // 通知時刻
                  Text('通知時刻', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
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
        onCancel: () => Navigator.pop(context),
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

Future<void> _handleSubmit(
  BuildContext context,
  WidgetRef ref,
  GlobalKey<FormBuilderState> formKey,
  UserResponse userDto,
  RotationResponse? originalRotation,
  bool isUpdateMode,
) async {
  if (formKey.currentState!.saveAndValidate()) {
    final formData = formKey.currentState!.value;
    final rotationController = ref.read(rotationNotifierProvider.notifier);

    try {
      final Result<RotationResponse> result;

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
        result = await rotationController.updateRotation(dto);
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
        result = await rotationController.createRotation(dto);
      }

      final message = result.when(
        success:
            (_) =>
                isUpdateMode
                    ? '${formData['rotationName']}を更新しました'
                    : '${formData['rotationName']}を作成しました',
        failure: (error) => error.message,
      );

      if (context.mounted) {
        SnackBarUtils.showGlassSnackBar(
          context: context,
          flexibleMessage: message,
        );
        Navigator.pop(context);
      }
    } catch (error) {
      if (context.mounted) {
        SnackBarUtils.showGlassSnackBar(
          context: context,
          flexibleMessage: 'エラーが発生しました',
        );
      }
    }
  }
}
