import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/features/auth/providers/user_provider.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final availableHeight = screenHeight - statusBarHeight;

    return Drawer(
      backgroundColor: Colors.transparent,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 0,
        blur: 20,
        alignment: Alignment.center,
        border: 0,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.1),
            const Color(0xFFffffff).withOpacity(0.05),
          ],
          stops: const [0.1, 1],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.transparent, Colors.transparent],
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                height: availableHeight * 0.25,
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    // RiverPodに応じて部分的に再レンダリング
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
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          user?.email ?? "未ログイン",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.7,
                                            ),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                failure:
                                    (_) => Column(
                                      children: [
                                        Text(
                                          "ゲスト",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "未ログイン",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.7,
                                            ),
                                            fontSize: 12,
                                          ),
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
                  ],
                ),
              ),

              // Menu
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
              ),

              // Sign Out
              Container(
                padding: EdgeInsets.all(12),
                child: GlassmorphicContainer(
                  width: double.infinity,
                  height: 48,
                  borderRadius: 12,
                  blur: 15,
                  alignment: Alignment.center,
                  border: 1,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.red.withOpacity(0.3),
                      Colors.red.withOpacity(0.1),
                    ],
                    stops: const [0.1, 1],
                  ),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.red.withOpacity(0.4),
                      Colors.red.withOpacity(0.4),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _showSignOutDialog(context);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'サインアウト',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
    return GlassmorphicContainer(
      width: double.infinity,
      height: 52,
      borderRadius: 12,
      blur: 15,
      alignment: Alignment.center,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.1),
          const Color(0xFFffffff).withOpacity(0.05),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.2)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 20),
                SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GlassmorphicContainer(
            width: 300,
            height: 200,
            borderRadius: 16,
            blur: 20,
            alignment: Alignment.center,
            border: 1,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFffffff).withOpacity(0.15),
                const Color(0xFFffffff).withOpacity(0.05),
              ],
              stops: const [0.1, 1],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.3),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'サインアウト',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '本当にサインアウトしますか？',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GlassmorphicContainer(
                          width: double.infinity,
                          height: 40,
                          borderRadius: 8,
                          blur: 10,
                          alignment: Alignment.center,
                          border: 1,
                          linearGradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                          borderGradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0.3),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'キャンセル',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: GlassmorphicContainer(
                          width: double.infinity,
                          height: 40,
                          borderRadius: 8,
                          blur: 10,
                          alignment: Alignment.center,
                          border: 1,
                          linearGradient: LinearGradient(
                            colors: [
                              Colors.red.withOpacity(0.3),
                              Colors.red.withOpacity(0.1),
                            ],
                          ),
                          borderGradient: LinearGradient(
                            colors: [
                              Colors.red.withOpacity(0.4),
                              Colors.red.withOpacity(0.4),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                                _authRepository.signOut();
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'はい',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
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
