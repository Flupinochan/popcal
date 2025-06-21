import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/providers/user_provider.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/presentation/view_models/rotation_view_model.dart';
import 'package:popcal/features/rotation/presentation/widgets/bottom_action_bar.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_list.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_rotation_name.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_date.dart';
import 'package:popcal/features/rotation/presentation/widgets/section_label.dart';

class RotationScreen extends HookConsumerWidget {
  const RotationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(rotationViewModelProvider).isLoading;
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final rotationViewModel = ref.read(rotationViewModelProvider.notifier);
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
          notificationTime: formData['notificationTime'] as DateTime,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await rotationViewModel.createRotationGroup(rotationGroup);
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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
        child: FormBuilder(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 100.0, bottom: 90),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ローテーション追加',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  const SectionLabel('ローテーション名'),
                  const SizedBox(height: 8),
                  const FormRotationName(),
                  const SizedBox(height: 24),
                  FormList(
                    name: 'rotationMembers',
                    hintText: 'メンバー名を入力',
                    initialValue: const ['太郎', '次郎', '三郎'],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'メンバーを1つ以上追加してください';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  const SectionLabel('ローテーションのスケジュール設定'),
                  const SizedBox(height: 8),
                  const FormDate(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        isLoading: isLoading,
        onCancel: () => Navigator.pop(context),
        onSubmit: () async {
          await handleCreateRotationGroup();
          // 成功時のみナビゲーション
          if (context.mounted && !isLoading) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
