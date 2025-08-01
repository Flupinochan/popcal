import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/core/utils/result.dart';
import 'package:popcal/features/auth/data/dto/email_sign_in_request_dto.dart';
import 'package:popcal/features/auth/domain/entities/auth_mode.dart';
import 'package:popcal/features/auth/domain/entities/login_form_field.dart';
import 'package:popcal/features/auth/domain/value_objects/email.dart';
import 'package:popcal/features/auth/domain/value_objects/password.dart';
import 'package:popcal/features/auth/providers/auth_view_model.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/glass_button.dart';
import 'package:popcal/shared/widgets/glass_dialog.dart';
import 'package:popcal/features/auth/presentation/widgets/glass_form_password.dart';
import 'package:popcal/shared/widgets/glass_form_text.dart';
import 'package:popcal/shared/widgets/glass_icon.dart';
import 'package:popcal/features/auth/presentation/widgets/glass_toggle_button.dart';
import 'package:popcal/shared/widgets/glass_wrapper.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;
    final isLoading = ref.watch(authViewModelProvider).isLoading;
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final selectedMode = useState(AuthMode.signIn);

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
                                text: AuthMode.signIn.displayName,
                                isSelected:
                                    selectedMode.value == AuthMode.signIn,
                                onPressed:
                                    () => selectedMode.value = AuthMode.signIn,
                              ),
                            ),
                            SizedBox(width: 8),
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
                        SizedBox(height: 20),
                        // Form (Email & Password)
                        Column(
                          children: [
                            // Email フィールド
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  LoginFormField.email.key,
                                  style: textTheme.titleMedium,
                                ),
                                SizedBox(height: 8),
                                GlassFormText(
                                  name: LoginFormField.email.key,
                                  hintText:
                                      'Enter your ${LoginFormField.email.key}',
                                  prefixIcon: Icons.email_outlined,
                                  validator: (value) {
                                    final result = Email.create(value);
                                    return result.when(
                                      success: (_) => null,
                                      failure: (error) => error.message,
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
                                Text(
                                  LoginFormField.password.key,
                                  style: textTheme.titleMedium,
                                ),
                                SizedBox(height: 8),
                                GlassFormPassword(
                                  name: LoginFormField.password.key,
                                  hintText:
                                      'Enter your ${LoginFormField.password.key}',
                                  prefixIcon: Icons.lock_outline,
                                  validator: (value) {
                                    final result = Password.create(value);
                                    return result.when(
                                      success: (_) => null,
                                      failure: (error) => error.message,
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
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: glassTheme.surfaceColor,
                                  strokeWidth: 3,
                                ),
                              ),
                            )
                            : GlassButton(
                              text: selectedMode.value.displayName,
                              height: 50,
                              onPressed:
                                  () => _handleSubmit(
                                    context,
                                    ref,
                                    formKey,
                                    selectedMode,
                                  ),
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

  // サインイン/サインアップ処理
  Future<void> _handleSubmit(
    BuildContext context,
    WidgetRef ref,
    GlobalKey<FormBuilderState> formKey,
    ValueNotifier<AuthMode> selectedMode,
  ) async {
    if (!formKey.currentState!.saveAndValidate()) return;

    final formData = formKey.currentState!.value;
    final email = formData[LoginFormField.email.key] as String;
    final password = formData[LoginFormField.password.key] as String;

    final dtoResult = EmailSignInRequestDto.create(
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

    final authViewModel = ref.read(authViewModelProvider.notifier);
    final authResult =
        selectedMode.value == AuthMode.signIn
            ? await authViewModel.signIn(dto)
            : await authViewModel.signUp(dto);
    if (!context.mounted) return;
    authResult.when(
      success: (user) {
        context.push(Routes.home);
      },
      failure: (error) {
        showErrorDialog(context, error.message);
      },
    );
  }
}
