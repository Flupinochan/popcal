import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/providers/core_provider.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/presentation/dto/user_response.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/auth/providers/auth_stream.dart';
import 'package:popcal/features/drawer/presentation/widgets/glass_menu_item.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

/// 環境変数にすべき値
final Uri _url = Uri.parse('https://flupinochan.github.io/popcal-document/');

class DrawerScreen extends HookConsumerWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final authRepository = ref.read(authRepositoryProvider);
    final linkColor = Colors.blue.withValues(alpha: 0.8);

    return Drawer(
      backgroundColor: glassTheme.backgroundColor,
      child: GlassWrapper(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon
                    const GlassIcon(
                      iconData: Icons.person,
                      iconSize: 40,
                      backgroundSize: 60,
                    ),
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
                                  return userDto == null
                                      ? _buildUserInfo(textTheme, null)
                                      : _buildUserInfo(textTheme, userDto);
                                },
                                failure: (_) => _buildUserInfo(textTheme, null),
                              ),
                          loading: () => _buildUserInfo(textTheme, null),
                          error: (_, _) => _buildUserInfo(textTheme, null),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Menu
                Expanded(
                  child: Column(
                    spacing: 12,
                    children: [
                      GlassMenuItem(
                        icon: Icons.home,
                        title: 'ホーム',
                        onTap: () => _onHomeTap(context),
                      ),
                      GlassMenuItem(
                        icon: Icons.event_note,
                        title: '月末営業日通知',
                        onTap: () => _onMonthEndTap(context),
                      ),
                    ],
                  ),
                ),
                // Sign Out
                GlassButton(
                  text: 'サインアウト',
                  height: 50,
                  borderColor: glassTheme.errorBorderColor,
                  gradient: glassTheme.errorGradient,
                  // ignore: unnecessary_lambdas 非同期関数のため
                  onPressed: () => authRepository.signOut(),
                ),
                const SizedBox(height: 16),
                // Document Link
                TextButton.icon(
                  // ignore: unnecessary_lambdas 非同期関数のため
                  onPressed: () => _showDocumentPage(),
                  icon: Icon(
                    Icons.open_in_new,
                    color: linkColor,
                    size: 16,
                  ),
                  label: Text(
                    'How to use PopCal',
                    style: textTheme.bodyMedium?.copyWith(
                      color: linkColor,
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

  Widget _buildUserInfo(TextTheme textTheme, UserResponse? userDto) {
    final email = userDto?.email;
    return Column(
      children: [
        Text(
          email == null ? '読み込み中...' : email.localPart,
          style: textTheme.titleMedium,
        ),
        Text(
          email == null ? 'お待ちください' : email.domain,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }

  void _onHomeTap(BuildContext context) {
    context.pop();
    const HomeRoute().go(context);
  }

  void _onMonthEndTap(BuildContext context) {
    context.pop();
    const DeadlineRoute().go(context);
  }

  Future<void> _showDocumentPage() async {
    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $_url');
    }
  }
}
