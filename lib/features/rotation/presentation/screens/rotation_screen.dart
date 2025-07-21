import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/providers/user_provider.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';
import 'package:popcal/features/rotation/presentation/view_models/rotation_view_model.dart';
import 'package:popcal/features/rotation/providers/rotation_detail_provider.dart';
import 'package:popcal/features/rotation/presentation/widgets/glass_button_action_bar.dart';
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
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final isUpdateMode = rotationGroupId != null;
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final rotationViewModel = ref.read(rotationViewModelProvider.notifier);
    final isLoading = ref.watch(rotationViewModelProvider).isLoading;

    final currentUserState = ref.watch(currentUserProvider);
    final currentUser = currentUserState.when(
      data:
          (result) =>
              result.when(success: (user) => user, failure: (_) => null),
      loading: () => null,
      error: (_, __) => null,
    );

    Future<void> handleCreateRotationGroup() async {
      if (currentUser == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('ログインが必要です')));
        }
        return;
      }

      if (formKey.currentState!.saveAndValidate()) {
        final formData = formKey.currentState!.value;

        final rotationGroup = RotationGroup(
          rotationGroupId: null,
          ownerUserId: currentUser.uid,
          rotationName: formData['rotationName'] as String,
          rotationMembers: List<String>.from(
            formData['rotationMembers'] as List,
          ),
          rotationDays: formData['rotationDays'] as List<Weekday>,
          notificationTime: formData['notificationTime'] as TimeOfDay,
          rotationStartDate: DateTime.now().toLocal(),
          updatedAt: DateTime.now().toLocal(),
        );

        final result = await rotationViewModel.createRotationGroup(
          rotationGroup,
        );

        result.when(
          success: (_) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('作成しました')));
              Navigator.pop(context);
            }
          },
          failure: (error) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('エラーが発生しました: $error')));
            }
          },
        );
      }
    }

    Future<void> handleUpdateRotationGroup(
      RotationGroup originalRotationGroup,
    ) async {
      if (currentUser == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('ログインが必要です')));
        }
        return;
      }

      if (formKey.currentState!.saveAndValidate()) {
        final formData = formKey.currentState!.value;

        final updatedRotationGroup = originalRotationGroup.copyWith(
          rotationName: formData['rotationName'] as String,
          rotationMembers: List<String>.from(
            formData['rotationMembers'] as List,
          ),
          rotationDays: formData['rotationDays'] as List<Weekday>,
          notificationTime: formData['notificationTime'] as TimeOfDay,
          updatedAt: DateTime.now().toLocal(),
        );

        final result = await rotationViewModel.updateRotationGroup(
          updatedRotationGroup,
        );

        result.when(
          success: (_) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('更新しました')));
              Navigator.pop(context);
            }
          },
          failure: (error) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('エラーが発生しました: $error')));
            }
          },
        );
      }
    }

    // 新規作成モード
    if (!isUpdateMode) {
      return _buildFormScreen(
        context: context,
        formKey: formKey,
        isUpdateMode: false,
        initialRotationGroup: null,
        isLoading: isLoading,
        onSubmit: handleCreateRotationGroup,
        glass: glass,
      );
    }

    // 編集モード - currentUserが必要
    if (currentUser == null) {
      return _buildLoadingScreen();
    }

    // 編集モード - AsyncNotifierProviderを使用
    final rotationDetailAsync = ref.watch(
      rotationDetailProvider(currentUser.uid, rotationGroupId!),
    );

    return rotationDetailAsync.when(
      data: (rotationGroup) {
        if (rotationGroup == null) {
          return _buildErrorScreen(context, 'データが見つかりません');
        }
        return _buildFormScreen(
          context: context,
          formKey: formKey,
          isUpdateMode: true,
          initialRotationGroup: rotationGroup,
          isLoading: isLoading,
          onSubmit: () => handleUpdateRotationGroup(rotationGroup),
          glass: glass,
        );
      },
      loading: () => _buildLoadingScreen(),
      error: (error, stack) => _buildErrorScreen(context, 'エラーが発生しました: $error'),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildErrorScreen(BuildContext context, String message) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormScreen({
    required BuildContext context,
    required GlobalKey<FormBuilderState> formKey,
    required bool isUpdateMode,
    required RotationGroup? initialRotationGroup,
    required bool isLoading,
    required VoidCallback onSubmit,
    required GlassTheme glass,
  }) {
    return Scaffold(
      backgroundColor: glass.backgroundColor,
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
        decoration: BoxDecoration(gradient: glass.primaryGradient),
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
        onSubmit: onSubmit,
      ),
    );
  }
}
