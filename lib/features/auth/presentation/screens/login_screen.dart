import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/results.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';
import 'package:popcal/features/auth/presentation/dto/email_sign_in_request.dart';
import 'package:popcal/features/auth/presentation/enums/auth_mode.dart';
import 'package:popcal/features/auth/presentation/enums/login_form_key.dart';
import 'package:popcal/features/auth/presentation/widgets/glass_form_password.dart';
import 'package:popcal/features/auth/presentation/widgets/glass_toggle_button.dart';
import 'package:popcal/features/auth/providers/auth_notifier.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_dialog.dart';
import 'package:popcal/shared/widgets/glass_form_text.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final mediaQuery = MediaQuery.of(context);
    final isLoading = ref.watch(authNotifierProvider).isLoading;
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);
    final selectedMode = useState(AuthMode.signIn);
    final loginFormKey = LoginFormKey.email.key;
    final passwordFormKey = LoginFormKey.password.key;
    final dividerColor = glassTheme.surfaceColor.withValues(
      alpha: 0.3,
    );

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          child: FormBuilder(
            key: formKey,
            child: SingleChildScrollView(
              // height: double.infinity かつ SingleChildScrollView でスクロール可能な場合に
              // ConstrainedBoxで中央寄せ
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      mediaQuery.size.height -
                      mediaQuery.padding.top -
                      mediaQuery.padding.bottom,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: GlassWrapper(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Lock Icon
                        const GlassIcon(
                          iconData: Icons.lock_outline_rounded,
                          iconSize: 30,
                        ),
                        const SizedBox(height: 24),
                        // Welcome Text
                        Text(
                          'Welcome to Popcal',
                          style: textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        // Description Text
                        Text(
                          'Sign in to your account or create a new one',
                          style: textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        // Sign In/Sign Up セグメント
                        Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: GlassToggleButton(
                                height: 40,
                                text: AuthMode.signIn.displayName,
                                isSelected:
                                    selectedMode.value == AuthMode.signIn,
                                onPressed:
                                    () => selectedMode.value = AuthMode.signIn,
                              ),
                            ),
                            Expanded(
                              child: GlassToggleButton(
                                height: 40,
                                text: AuthMode.signUp.displayName,
                                isSelected:
                                    selectedMode.value == AuthMode.signUp,
                                onPressed:
                                    () => selectedMode.value = AuthMode.signUp,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Form (Email & Password)
                        Column(
                          spacing: 20,
                          children: [
                            // Email フィールド
                            Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loginFormKey,
                                  style: textTheme.titleMedium,
                                ),
                                GlassFormText(
                                  name: loginFormKey,
                                  hintText: 'Enter your $loginFormKey',
                                  prefixIcon: Icons.email_outlined,
                                  validator: _validateEmail,
                                ),
                              ],
                            ),
                            // Password フィールド
                            Column(
                              spacing: 8,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  passwordFormKey,
                                  style: textTheme.titleMedium,
                                ),
                                GlassFormPassword(
                                  name: passwordFormKey,
                                  hintText: 'Enter your $passwordFormKey',
                                  prefixIcon: Icons.lock_outline,
                                  validator: _validatePassword,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        // Sign In/Sign Up ボタン
                        if (isLoading)
                          GlassWrapper(
                            height: 50,
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: glassTheme.surfaceColor,
                                strokeWidth: 3,
                              ),
                            ),
                          )
                        else
                          GlassButton(
                            text: selectedMode.value.displayName,
                            height: 50,
                            onPressed:
                                () => _handleSubmit(
                                  context,
                                  ref,
                                  formKey,
                                  selectedMode,
                                  loginFormKey,
                                  passwordFormKey,
                                ),
                          ),
                        const SizedBox(height: 20),
                        // Forgot password リンク
                        Text(
                          'Forgot your password?',
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 24),
                        // OR CONTINUE WITH
                        Row(
                          spacing: 16,
                          children: [
                            Expanded(
                              child: Divider(color: dividerColor),
                            ),
                            Text(
                              'OR CONTINUE WITH',
                              style: textTheme.bodySmall,
                            ),
                            Expanded(
                              child: Divider(color: dividerColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Google & GitHub ボタン
                        const Row(
                          spacing: 16,
                          children: [
                            Expanded(
                              child: GlassButton(
                                iconData: Icons.g_mobiledata,
                                text: 'Google',
                                height: 50,
                              ),
                            ),
                            Expanded(
                              child: GlassButton(
                                iconData: Icons.code,
                                text: 'GitHub',
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Contact Support
                        Row(
                          spacing: 4,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                'Need help? ',
                                style: textTheme.bodyMedium,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Contact Support',
                                style: textTheme.labelLarge,
                              ),
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

  // サインイン/サインアップ処理
  Future<void> _handleSubmit(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormBuilderState> formKey,
    ValueNotifier<AuthMode> selectedMode,
    String loginFormKey,
    String passwordFormKey,
  ) async {
    if (!formKey.currentState!.saveAndValidate()) return;

    final formData = formKey.currentState!.value;
    final email = formData[loginFormKey] as String;
    final password = formData[passwordFormKey] as String;

    final dtoResult = EmailSignInRequest.create(
      email: email,
      password: password,
    );
    if (dtoResult.isFailure) {
      if (context.mounted) {
        showErrorDialog(context, dtoResult.displayText);
      }
      return;
    }
    final dto = dtoResult.valueOrNull!;

    final authViewModel = ref.read(authNotifierProvider.notifier);
    final authResult =
        selectedMode.value == AuthMode.signIn
            ? await authViewModel.signIn(dto)
            : await authViewModel.signUp(dto);
    if (!context.mounted) return;
    authResult.when(
      success: (user) {
        const HomeRoute().go(context);
      },
      failure: (error) {
        showErrorDialog(context, error.message);
      },
    );
  }

  String _validateEmail(String? value) {
    final result = Email.create(value);
    return result.when(
      success: (_) => '',
      failure: (error) => error.message,
    );
  }

  String _validatePassword(String? value) {
    final result = Password.create(value);
    return result.when(
      success: (_) => '',
      failure: (error) => error.message,
    );
  }
}
