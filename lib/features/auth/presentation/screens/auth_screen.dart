import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/failures.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/domain/entities/user.dart';
import 'package:popcal/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:popcal/features/auth/providers/auth_providers.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_form_password.dart';
import 'package:popcal/shared/widgets/glass_form_text.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_toggle_button.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final glassTheme = Theme.of(context).extension<GlassTheme>()!;
    final textTheme = Theme.of(context).textTheme;
    final authViewModel = ref.read(authViewModelProvider.notifier);
    final isLoading = ref.watch(authViewModelProvider).isLoading;
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final selectedMode = useState('Sign In');
    final validator = ref.read(emailSignInValidatorProvider);

    /// サインイン/サインアップ処理
    Future<void> handleSubmit() async {
      if (formKey.currentState!.saveAndValidate()) {
        final formData = formKey.currentState!.value;
        final email = formData['email'] as String;
        final password = formData['password'] as String;

        Either<Failure, AppUser?> result;
        if (selectedMode.value == 'Sign In') {
          result = await authViewModel.signIn(email, password);
        } else {
          result = await authViewModel.signUp(email, password);
        }
        result.when(
          success: (user) {
            context.push(Routes.home);
          },
          failure: (error) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('エラー: ${error.message}')));
            }
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          child: FormBuilder(
            key: formKey,
            enabled: true,
            child: SingleChildScrollView(
              // height: double.infinity かつ SingleChildScrollView でスクロール可能な場合に
              // ConstrainedBoxで中央寄せ
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: GlassWrapper(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Lock Icon
                        GlassIcon(
                          iconData: Icons.lock_outline_rounded,
                          iconSize: 30,
                        ),
                        SizedBox(height: 24),
                        // Welcome Text
                        Text(
                          'Welcome to Popcal',
                          style: textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        // Description Text
                        Text(
                          'Sign in to your account or create a new one',
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        // Sign In/Sign Up セグメント
                        Row(
                          children: [
                            Expanded(
                              child: GlassToggleButton(
                                height: 40,
                                text: 'Sign In',
                                isSelected: selectedMode.value == 'Sign In',
                                onPressed: () => selectedMode.value = 'Sign In',
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: GlassToggleButton(
                                height: 40,
                                text: 'Sign Up',
                                isSelected: selectedMode.value == 'Sign Up',
                                onPressed: () => selectedMode.value = 'Sign Up',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // Form (Email & Password)
                        Column(
                          children: [
                            // Email フィールド
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email', style: textTheme.titleMedium),
                                SizedBox(height: 8),
                                GlassFormText(
                                  name: 'email',
                                  hintText: 'Enter your email',
                                  prefixIcon: Icons.email_outlined,
                                  validator: (value) {
                                    if (value == null) return '入力してください';
                                    final result = validator.validateEmail(
                                      value,
                                    );
                                    return result.when(
                                      success: (_) => null,
                                      failure: (error) => error.toString(),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            // Password フィールド
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Password', style: textTheme.titleMedium),
                                SizedBox(height: 8),
                                GlassFormPassword(
                                  name: 'password',
                                  hintText: 'Enter your password',
                                  prefixIcon: Icons.lock_outline,
                                  validator: (value) {
                                    if (value == null) return '入力してください';
                                    final result = validator.validatePassword(
                                      value,
                                    );
                                    return result.when(
                                      success: (_) => null,
                                      failure: (error) => error.toString(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        // Sign In/Sign Up ボタン
                        isLoading
                            ? GlassWrapper(
                              height: 50,
                              child: CircularProgressIndicator(
                                color: glassTheme.surfaceColor,
                                strokeWidth: 3,
                              ),
                            )
                            : GlassButton(
                              text: selectedMode.value,
                              height: 50,
                              onPressed: handleSubmit,
                            ),
                        SizedBox(height: 20),
                        // Forgot password リンク
                        Text(
                          'Forgot your password?',
                          style: textTheme.bodyMedium,
                        ),
                        SizedBox(height: 24),
                        // OR CONTINUE WITH
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: glassTheme.surfaceColor.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'OR CONTINUE WITH',
                              style: textTheme.bodySmall,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Divider(
                                color: glassTheme.surfaceColor.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        // Google & GitHub ボタン
                        Row(
                          children: [
                            Expanded(
                              child: GlassButton(
                                iconData: Icons.g_mobiledata,
                                text: 'Google',
                                height: 50,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: GlassButton(
                                iconData: Icons.code,
                                text: 'GitHub',
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        // Contact Support
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Need help? ', style: textTheme.bodyMedium),
                            SizedBox(width: 4),
                            Text(
                              'Contact Support',
                              style: textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
