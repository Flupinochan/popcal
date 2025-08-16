import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/rotation/domain/value_objects/notification_time.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_days.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_id.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_member_names.dart';
import 'package:popcal/features/rotation/domain/value_objects/rotation_name.dart';
import 'package:popcal/features/rotation/domain/value_objects/skip_events.dart';
import 'package:popcal/features/rotation/presentation/dto/create_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/dto/rotation_response.dart';
import 'package:popcal/features/rotation/presentation/dto/update_rotation_request.dart';
import 'package:popcal/features/rotation/presentation/widgets/bottom_action_bar/glass_bottom_action_bar.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_list.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_time.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_form_weekday.dart';
import 'package:popcal/features/rotation/providers/rotation_loader.dart';
import 'package:popcal/features/rotation/providers/rotation_notifier.dart';
import 'package:popcal/shared/providers/utils_providers.dart';
import 'package:popcal/shared/screens/custom_error_screen.dart';
import 'package:popcal/shared/screens/custom_loading_screen.dart';
import 'package:popcal/shared/utils/snackbar_utils.dart';
import 'package:popcal/shared/widgets/glass_app_bar/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_dialog.dart';
import 'package:popcal/shared/widgets/glass_form_text.dart';

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
                    validator: _validateRotationName,
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
                      validator: _validateRotationMemberNames,
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
                    initialValue:
                        initialRotation == null
                            ? TimeOfDay.fromDateTime(now)
                            : initialRotation.notificationTime.timeOfDay,
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
      final rotationNotifier = ref.read(rotationNotifierProvider.notifier);

      final rotationNameResult = RotationName.create(
        formData['rotationName'] as String,
      );
      if (rotationNameResult.isFailure) {
        showErrorDialog(context, rotationNameResult.failureOrNull!.message);
        return;
      }

      final rotationMemberNamesResult = RotationMemberNames.createFromDynamic(
        formData['rotationMembers'] as List,
      );
      if (rotationMemberNamesResult.isFailure) {
        showErrorDialog(
          context,
          rotationMemberNamesResult.failureOrNull!.message,
        );
        return;
      }

      final selectedTime = formData['notificationTime'] as TimeOfDay;

      try {
        if (isUpdateMode) {
          final dto = UpdateRotationRequest(
            userId: userDto.userId,
            rotationId: originalRotation!.rotationId,
            rotationName: rotationNameResult.valueOrNull!,
            rotationMembers: rotationMemberNamesResult.valueOrNull!,
            rotationDays: formData['rotationDays'] as RotationDays,
            notificationTime: NotificationTime(
              hour: selectedTime.hour,
              minute: selectedTime.minute,
            ),
            createdAt: originalRotation.createdAt,
            skipEvents: const SkipEvents([]),
          );
          await rotationNotifier.updateRotation(dto);
        } else {
          final dto = CreateRotationRequest(
            userId: userDto.userId,
            rotationName: RotationName(formData['rotationName'] as String),
            rotationMembers: rotationMemberNamesResult.valueOrNull!,
            rotationDays: formData['rotationDays'] as RotationDays,
            notificationTime: NotificationTime(
              hour: selectedTime.hour,
              minute: selectedTime.minute,
            ),
            skipEvents: const SkipEvents([]),
          );
          await rotationNotifier.createRotation(dto);
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
      } on Exception catch (_) {
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

  String? _validateRotationMemberNames(List<String>? value) {
    final result = RotationMemberNames.create(value);
    return result.when(
      success: (_) => null,
      failure: (error) => error.message,
    );
  }

  String? _validateRotationName(String? value) {
    final result = RotationName.create(value);
    return result.when(
      success: (_) => null,
      failure: (error) => error.message,
    );
  }
}
