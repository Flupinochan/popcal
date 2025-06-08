import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/auth/login/domain/repositories/auth_repository.dart';
import 'package:popcal/features/auth/login/presentation/providers/auth_providers.dart';
import 'package:popcal/features/auth/login/presentation/providers/user_provider.dart';

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
    return Drawer(
      child: Column(
        children: [
          // Header
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigoAccent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 10),
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      user?.email ?? "未ログイン",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "未ログイン",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "お待ちください",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "読み込みに失敗しました",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
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
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('ホーム'),
                  onTap: () {
                    Navigator.pop(context);
                    // ホーム画面への遷移処理
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('プロフィール'),
                  onTap: () {
                    Navigator.pop(context);
                    // プロフィール画面への遷移処理
                  },
                ),
              ],
            ),
          ),

          // Sign Out
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showSignOutDialog(context);
                },
                icon: Icon(Icons.logout),
                label: Text('サインアウト'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('サインアウト'),
          content: Text('本当にサインアウトしますか？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _authRepository.signOut();
              },
              child: Text('はい'),
            ),
          ],
        );
      },
    );
  }
}
