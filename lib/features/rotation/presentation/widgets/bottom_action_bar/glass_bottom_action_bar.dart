import 'package:flutter/material.dart';
import 'package:popcal/features/rotation/presentation/widgets/bottom_action_bar/custom_circular_indicator.dart';
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
    const widgetHeight = 50.0;
    const circleHeight = 26.0;

    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: Row(
        spacing: 16,
        children: [
          // キャンセル
          Expanded(
            child:
                isLoading
                    ? const CustomCircularIndicator(
                      height: widgetHeight,
                      circleHeight: circleHeight,
                    )
                    : GlassButton(
                      width: double.infinity,
                      height: widgetHeight,
                      showBackground: false,
                      text: 'キャンセル',
                      onPressed: onCancel,
                    ),
          ),
          // 作成/更新
          Expanded(
            child:
                isLoading
                    ? const CustomCircularIndicator(
                      height: widgetHeight,
                      circleHeight: circleHeight,
                    )
                    : GlassButton(
                      width: double.infinity,
                      height: widgetHeight,
                      showBorder: false,
                      text: isUpdateMode ? '更新' : '作成',
                      onPressed: onSubmit,
                    ),
          ),
        ],
      ),
    );
  }
}
