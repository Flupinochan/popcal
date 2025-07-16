import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/providers/user_provider.dart';
import 'package:popcal/features/rotation/domain/entities/rotation_group.dart';
import 'package:popcal/features/rotation/domain/entities/weekday.dart';
import 'package:popcal/features/rotation/presentation/view_models/rotation_view_model.dart';
import 'package:popcal/features/rotation/presentation/widgets/bottom_action_bar.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_list.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_rotation_name.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_time_selector.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_weekday_selector.dart';
import 'package:popcal/features/rotation/presentation/widgets/section_label.dart';

class RotationScreen extends HookConsumerWidget {
  // 編集時は値を代入
  final String? rotationGroupId;

  const RotationScreen({super.key, this.rotationGroupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUpdateMode = rotationGroupId != null;
    final initialRotationGroup = useState<RotationGroup?>(null);
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

    // 編集時のデータ取得（後で実装）
    useEffect(() {
      if (isUpdateMode) {
        // TODO: 既存データの取得処理
        // initialRotationGroup.value = xxx;
      }
      return null;
    }, [isUpdateMode]);

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
          rotationGroupId: isUpdateMode ? rotationGroupId : null,
          ownerUserId: currentUser.uid,
          rotationName: formData['rotationName'] as String,
          rotationMembers: List<String>.from(
            formData['rotationMembers'] as List,
          ),
          rotationDays: formData['rotationDays'] as List<Weekday>,
          notificationTime: formData['notificationTime'] as TimeOfDay,
          createdAt:
              isUpdateMode
                  ? (initialRotationGroup.value?.createdAt ??
                      DateTime.now().toLocal())
                  : DateTime.now().toLocal(),
          updatedAt: DateTime.now().toLocal(),
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
                  FormRotationName(
                    initialValue: initialRotationGroup.value?.rotationName,
                  ),
                  const SizedBox(height: 24),
                  FormList(
                    name: 'rotationMembers',
                    hintText: 'メンバー名を入力',
                    initialValue: initialRotationGroup.value?.rotationMembers,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'メンバーを1つ以上追加してください';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  const SectionLabel('ローテーション曜日'),
                  const SizedBox(height: 8),
                  FormWeekdaySelector(
                    initialValue: initialRotationGroup.value?.rotationDays,
                  ),
                  const SizedBox(height: 24),
                  const SectionLabel('通知時刻'),
                  const SizedBox(height: 8),
                  FormTimeSelector(
                    initialValue: initialRotationGroup.value?.notificationTime,
                  ),
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
