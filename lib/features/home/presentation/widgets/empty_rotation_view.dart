import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

/// ローテーションが1つもない場合の画面
class EmptyRotationView extends StatelessWidget {
  const EmptyRotationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassWrapper(
        width: 340,
        height: 240,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            GlassIcon(iconData: Icons.group_add),
            const SizedBox(height: 16),
            // Text1
            Text(
              'ローテーションがありません',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Text2
            Text(
              '新しいローテーションを作成してみましょう',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // 作成Button
            GlassButton(
              width: 120,
              height: 40,
              text: '作成',
              onPressed: () => context.push(Routes.rotation),
            ),
          ],
        ),
      ),
    );
  }
}
