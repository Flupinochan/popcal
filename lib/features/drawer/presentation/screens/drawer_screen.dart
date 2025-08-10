import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/providers/core_provider.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/auth/providers/auth_stream.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://flupinochan.github.io/popcal-document/');

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
                        final authResult = ref.watch(
                          authStateChangesForUIProvider,
                        );
                        return authResult.when(
                          data:
                              (result) => result.when(
                                success: (userDto) {
                                  if (userDto == null) {
                                    return _buildUserInfo(textTheme, null);
                                  } else {
                                    return _buildUserInfo(textTheme, userDto);
                                  }
                                },
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
                          context.pop();
                          context.go(Routes.home);
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
                SizedBox(height: 16),
                // Document Link
                TextButton.icon(
                  onPressed: () async {
                    if (!await launchUrl(
                      _url,
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw Exception('Could not launch $_url');
                    }
                  },
                  icon: Icon(
                    Icons.open_in_new,
                    color: Colors.blue.withValues(alpha: 0.8),
                    size: 16,
                  ),
                  label: Text(
                    'How to use PopCal',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.blue.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                // Version
                Consumer(
                  builder: (context, ref, child) {
                    final packageInfoAsync = ref.watch(packageInfoProvider);
                    return packageInfoAsync.when(
                      data:
                          (packageInfo) => Text(
                            'version: ${packageInfo.version}',
                            style: textTheme.bodySmall,
                          ),
                      loading:
                          () => Text('読み込み中...', style: textTheme.bodySmall),
                      error:
                          (_, _) => Text(
                            'バージョン情報を取得できませんでした',
                            style: textTheme.bodySmall,
                          ),
                    );
                  },
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

  Widget _buildUserInfo(TextTheme textTheme, UserResponse? userDto) {
    return Column(
      children: [
        Text(
          userDto == null ? "読み込み中..." : userDto.email.value.split('@').first,
          style: textTheme.titleMedium,
        ),
        Text(
          userDto == null ? "お待ちください" : userDto.email.value,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
