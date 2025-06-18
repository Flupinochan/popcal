import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/features/rotation/presentation/widgets/bottom_action_bar.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_list.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_rotation_name.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_rotation_type.dart';
import 'package:popcal/features/rotation/presentation/widgets/form_date.dart';
import 'package:popcal/features/rotation/presentation/widgets/section_label.dart';

class RotationScreen extends HookConsumerWidget {
  const RotationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final isSubmitting = useState(false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ローテーション追加',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              SectionLabel('ローテーション名'),
              SizedBox(height: 8),
              // RotationName (FormBuilderTextField)
              FormRotationName(),
              SizedBox(height: 24),
              SectionLabel('ローテーションの種類'),
              SizedBox(height: 8),
              // RotationType (FormBuilderDropdown)
              FormRotationType(),
              SizedBox(height: 24),
              // Role List
              FormList(
                name: 'roles',
                hintText: '役割名を入力（例：ファシリテーター、議事録）',
                initialValue: ['ファシリテータ', '議事録'],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '役割を1つ以上追加してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              // Member List ※役割固定の場合は複数のListになるべき
              FormList(
                name: 'members',
                hintText: 'メンバー名を入力',
                initialValue: ['太郎', '次郎', '三郎'],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'メンバーを1つ以上追加してください';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              SectionLabel('ローテーションのスケジュール設定'),
              SizedBox(height: 8),
              // Schedule ※時刻だけではなく、曜日も選択可能にすべき
              FormDate(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomActionBar(
        onCancel: () => Navigator.pop(context),
        onSubmit: () => _onSubmit(formKey, isSubmitting),
        isSubmitting: isSubmitting.value,
      ),
    );
  }

  Future<void> _onSubmit(
    GlobalKey<FormBuilderState> formKey,
    ValueNotifier<bool> isSubmitting,
  ) async {
    if (formKey.currentState!.saveAndValidate()) {
      isSubmitting.value = true;

      try {
        final formData = formKey.currentState!.value;

        // 実際の保存処理をここに実装

        print('フォームデータ:');
        print('ローテーション名: ${formData['rotationName']}');
        print('ローテーション種類: ${formData['rotationType']}');
        print('役割: ${formData['roles']}');
        print('メンバー: ${formData['members']}');
        print('開始日: ${formData['startDate']}');
      } finally {
        isSubmitting.value = false;
      }
    }
  }
}
