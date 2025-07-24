import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/auth/providers/user_provider.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class DrawerScreen extends ConsumerStatefulWidget {
  const DrawerScreen({super.key});

  @override
  ConsumerState<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends ConsumerState<DrawerScreen> {
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = ref.read(authRepositoryProvider);
  }

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      backgroundColor: glass.backgroundColor,
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
                    // Consumerで部分再レンダリング
                    // name & email
                    Consumer(
                      builder: (context, ref, child) {
                        final userAsync = ref.watch(currentUserProvider);
                        return userAsync.when(
                          data:
                              (result) => result.when(
                                success:
                                    (user) => Column(
                                      children: [
                                        Text(
                                          user?.email.split('@').first ?? "ゲスト",
                                          style: textTheme.titleMedium,
                                        ),
                                        Text(
                                          user?.email ?? "未ログイン",
                                          style: textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                failure:
                                    (_) => Column(
                                      children: [
                                        Text(
                                          "ゲスト",
                                          style: textTheme.titleMedium,
                                        ),
                                        Text(
                                          "未ログイン",
                                          style: textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                              ),
                          loading:
                              () => Column(
                                children: [
                                  Text(
                                    "読み込み中...",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "お待ちください",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                          error:
                              (_, __) => Column(
                                children: [
                                  Text(
                                    "エラー",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "読み込みに失敗しました",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
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
                  borderColor: glass.errorBorderColor,
                  gradient: glass.errorGradient,
                  onPressed: () => _showSignOutDialog(context),
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

  void _showSignOutDialog(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GlassWrapper(
            height: 200,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('サインアウト', style: textTheme.titleLarge),
                  SizedBox(height: 16),
                  Text('本当にサインアウトしますか？', style: textTheme.bodyMedium),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GlassButton(
                          height: 40,
                          text: 'いいえ',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: GlassButton(
                          height: 40,
                          text: 'はい',
                          onPressed: () {
                            Navigator.of(context).pop();
                            _authRepository.signOut();
                          },
                          borderColor:
                              Theme.of(
                                context,
                              ).extension<GlassTheme>()!.errorBorderColor,
                          gradient:
                              Theme.of(
                                context,
                              ).extension<GlassTheme>()!.errorGradient,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
