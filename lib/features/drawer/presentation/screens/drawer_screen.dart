import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class DrawerScreen extends HookConsumerWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final authRepository = ref.read(authRepositoryProvider);

    return Drawer(
      backgroundColor: glassTheme.backgroundColor,
      child: GlassWrapper(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon
                    GlassIcon(
                      iconData: Icons.person,
                      iconSize: 40,
                      backgroundSize: 60,
                    ),
                    SizedBox(height: 8),
                    // Consumerで以下の部分だけ再レンダリング
                    // name & email
                    Consumer(
                      builder: (context, ref, child) {
                        final authResult = ref.watch(authStateChangesProvider);
                        return authResult.when(
                          data:
                              (result) => result.when(
                                success:
                                    (appUser) =>
                                        _buildUserInfo(textTheme, appUser),
                                failure: (_) => _buildUserInfo(textTheme, null),
                              ),
                          loading: () => _buildUserInfo(textTheme, null),
                          error: (_, __) => _buildUserInfo(textTheme, null),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                ),

                // Menu
                Expanded(
                  child: ListView(
                    children: [
                      _buildGlassMenuItem(
                        icon: Icons.home,
                        title: 'ホーム',
                        onTap: () {
                          Navigator.pop(context);
                          // ホーム画面への遷移処理
                        },
                      ),
                      SizedBox(height: 12),
                      _buildGlassMenuItem(
                        icon: Icons.person,
                        title: 'プロフィール',
                        onTap: () {
                          Navigator.pop(context);
                          // プロフィール画面への遷移処理
                        },
                      ),
                    ],
                  ),
                ),

                // Sign Out
                GlassButton(
                  text: "サインアウト",
                  height: 50,
                  borderColor: glassTheme.errorBorderColor,
                  gradient: glassTheme.errorGradient,
                  onPressed: () => authRepository.signOut(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GlassButton(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
      iconData: icon,
      text: title,
      onPressed: onTap,
      alignment: Alignment.centerLeft,
    );
  }

  Widget _buildUserInfo(TextTheme textTheme, AppUser? appUser) {
    return Column(
      children: [
        Text(
          appUser == null ? "読み込み中..." : appUser.email.split('@').first,
          style: textTheme.titleMedium,
        ),
        Text(
          appUser == null ? "お待ちください" : appUser.email,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
