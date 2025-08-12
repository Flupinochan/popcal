import 'package:flutter/material.dart';
import 'package:popcal/shared/widgets/glass_button.dart';

class GlassBottomActionBar extends StatelessWidget {
  const GlassBottomActionBar({
    required this.onCancel,
    required this.onSubmit,
    super.key,
    this.isLoading = false,
    this.isUpdateMode = false,
  });

  final bool isLoading;
  final bool isUpdateMode;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: Row(
        spacing: 16,
        children: [
          // キャンセル
          Expanded(
            child: GlassButton(
              width: double.infinity,
              height: 50,
              showBackground: false,
              text: 'キャンセル',
              onPressed: isLoading ? null : onCancel,
            ),
          ),
          // 作成/更新
          Expanded(
            child: GlassButton(
              width: double.infinity,
              height: 50,
              showBorder: false,
              text: isUpdateMode ? '更新' : '作成',
              onPressed: isLoading ? null : onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
