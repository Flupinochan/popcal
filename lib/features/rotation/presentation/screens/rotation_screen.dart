import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';
import 'package:popcal/features/rotation/providers/rotation_data_provider.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_button_action_bar.dart';
import 'package:popcal/features/rotation/providers/rotation_view_model.dart';
import 'package:popcal/shared/widgets/custom_error_widget.dart';
import 'package:popcal/shared/widgets/custom_loading_widget.dart';
import 'package:popcal/shared/utils/snackbar_utils.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_form_list.dart';
import 'package:popcal/shared/widgets/glass_form_text.dart';
import 'package:popcal/shared/widgets/glass_form_time.dart';
import 'package:popcal/shared/widgets/glass_form_weekday.dart';

class RotationScreen extends HookConsumerWidget {
  final String? rotationGroupId;

  const RotationScreen({super.key, this.rotationGroupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rotationDataAsync = ref.watch(rotationDataProvider(rotationGroupId));

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
    RotationData rotationData,
  ) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final isUpdateMode = rotationData.rotationGroup != null;
    final initialRotationGroup = rotationData.rotationGroup;
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isLoading = ref.watch(rotationViewModelProvider).isLoading;

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
                    initialValue: initialRotationGroup?.rotationName,
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
                    initialValue: initialRotationGroup?.rotationMembers,
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
                    initialValue: initialRotationGroup?.rotationDays,
                  ),
                  const SizedBox(height: 24),
                  // 通知時刻
                  Text('通知時刻', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  GlassFormTime(
                    initialValue: initialRotationGroup?.notificationTime,
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
              rotationData.appUser,
              initialRotationGroup,
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
  AppUser appUser,
  RotationGroup? originalRotationGroup,
  bool isUpdateMode,
) async {
  if (formKey.currentState!.saveAndValidate()) {
    final formData = formKey.currentState!.value;
    final rotationName = formData['rotationName'] as String;

    final rotationGroup =
        isUpdateMode
            ? originalRotationGroup!.copyWith(
              rotationName: rotationName,
              rotationMembers: List<String>.from(
                formData['rotationMembers'] as List,
              ),
              rotationDays: formData['rotationDays'] as List<Weekday>,
              notificationTime: formData['notificationTime'] as TimeOfDay,
              updatedAt: DateTime.now().toLocal(),
            )
            : RotationGroup(
              rotationGroupId: null,
              ownerUserId: appUser.uid,
              rotationName: rotationName,
              rotationMembers: List<String>.from(
                formData['rotationMembers'] as List,
              ),
              rotationDays: formData['rotationDays'] as List<Weekday>,
              notificationTime: formData['notificationTime'] as TimeOfDay,
              rotationStartDate: DateTime.now().toLocal(),
              updatedAt: DateTime.now().toLocal(),
            );

    final rotationViewModel = ref.read(rotationViewModelProvider.notifier);
    final result =
        isUpdateMode
            ? await rotationViewModel.updateRotationGroup(rotationGroup)
            : await rotationViewModel.createRotationGroup(rotationGroup);

    final message = result.when(
      success:
          (_) => isUpdateMode ? '$rotationNameを更新しました' : '$rotationNameを作成しました',
      failure: (error) => error.message,
    );

    if (context.mounted) {
      SnackBarUtils.showGlassSnackBar(context: context, message: message);
      Navigator.pop(context);
    }
  }
}
