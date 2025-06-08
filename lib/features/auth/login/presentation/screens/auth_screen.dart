import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcal/features/auth/login/data/dto/email_sign_in/email_sign_in_request_dto.dart';
import 'package:popcal/features/auth/login/domain/use_cases/email_sign_in_use_case.dart';
import 'package:popcal/features/auth/login/domain/use_cases/email_sign_up_use_case.dart';
import 'package:popcal/features/auth/login/presentation/providers/auth_providers.dart';
import 'package:popcal/features/auth/login/presentation/validators/email_sign_in_validator.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isPasswordVisible = false;
  String _selectedMode = 'Sign In';

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  late final EmailSignInValidator _emailSignInValidator;

  @override
  void initState() {
    super.initState();
    _emailSignInValidator = ref.read(emailSignInValidatorProvider);
  }

  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final result = await ref
          .read(emailSignInUseCaseProvider.notifier)
          .call(EmailSignInRequestDto(email: _email, password: _password));

      if (result.isFailure && mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.orange,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'エラー',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Text(result.toString(), style: TextStyle(fontSize: 14)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final result = await ref
          .read(emailSignUpUseCaseProvider.notifier)
          .call(EmailSignInRequestDto(email: _email, password: _password));

      if (result.isFailure && mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Row(
                children: [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.orange,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'エラー',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Text(result.toString(), style: TextStyle(fontSize: 14)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        _selectedMode == 'Sign In'
            ? ref.watch(emailSignInUseCaseProvider).isLoading
            : ref.watch(emailSignUpUseCaseProvider).isLoading;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.indigo[50]!, Colors.indigo],
          ),
        ),
        // SafeArea: wifiアイコンやcameraのある領域を避けてレンダリングする
        child: SafeArea(
          // SingleChildScrollView: keyboardが表示された際にoverflowしないようにスクロール可能にする
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Lock Icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.indigoAccent,
                            Color.fromARGB(255, 75, 63, 181),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                    SizedBox(height: 24),
                    // Welcome Text
                    Text(
                      'Welcome to Popcal',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    // Description Text
                    Text(
                      'Sign in to your account or create a new one',
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                    SizedBox(height: 16),
                    // Sign In/Sign Up セグメント
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton(
                        segments: [
                          ButtonSegment(
                            value: 'Sign In',
                            label: Text('Sign In'),
                          ),
                          ButtonSegment(
                            value: 'Sign Up',
                            label: Text('Sign Up'),
                          ),
                        ],
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                          backgroundColor:
                              WidgetStateProperty.resolveWith<Color>((
                                Set<WidgetState> states,
                              ) {
                                if (states.contains(WidgetState.selected)) {
                                  return Colors.indigoAccent;
                                }
                                return Colors.white;
                              }),
                          foregroundColor:
                              WidgetStateProperty.resolveWith<Color>((
                                Set<WidgetState> states,
                              ) {
                                if (states.contains(WidgetState.selected)) {
                                  return Colors.white;
                                }
                                return Colors.black54;
                              }),
                          side: WidgetStateProperty.resolveWith<BorderSide>((
                            Set<WidgetState> states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return BorderSide(
                                color: Colors.indigoAccent,
                                width: 2,
                              );
                            }
                            return BorderSide(
                              color: Colors.indigoAccent,
                              width: 1,
                            );
                          }),
                        ),
                        selected: {_selectedMode},
                        onSelectionChanged: (Set<String> newSelection) {
                          setState(() {
                            _selectedMode = newSelection.first;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Form (Email & Password)
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email フィールド
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    final result = _emailSignInValidator
                                        .validateEmail(value ?? '');
                                    if (result.isFailure) {
                                      return result.toString();
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _email = value ?? '',
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email',
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Colors.grey[500],
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          // Password フィールド
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    final result = _emailSignInValidator
                                        .validatePassword(value ?? '');
                                    if (result.isFailure) {
                                      return result.toString();
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _password = value ?? '',
                                  obscureText: !_isPasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: Colors.grey[500],
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey[500],
                                      ),
                                      onPressed:
                                          () => setState(
                                            () =>
                                                _isPasswordVisible =
                                                    !_isPasswordVisible,
                                          ),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                    // Sign In/Sign Up ボタン
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed:
                            isLoading
                                ? null
                                : (_selectedMode == 'Sign In'
                                    ? _handleSignIn
                                    : _handleSignUp),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2C2C2C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child:
                            isLoading
                                ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                : Text(
                                  _selectedMode,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Forgot password リンク
                    TextButton(
                      onPressed: () {
                        // パスワード忘れ処理
                      },
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 24),
                    // OR CONTINUE WITH
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey[300])),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'OR CONTINUE WITH',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Colors.grey[300])),
                      ],
                    ),
                    SizedBox(height: 24),
                    // Google & GitHub ボタン
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {
                                // Google ログイン
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey[300]!),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.g_mobiledata,
                                    color: Colors.black87,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Google',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {
                                // GitHub ログイン
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey[300]!),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.code, color: Colors.black87),
                                  SizedBox(width: 8),
                                  Text(
                                    'GitHub',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    // Contact Support
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Need help? ',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        TextButton(
                          onPressed: () {
                            // サポート画面へ
                          },
                          child: Text(
                            'Contact Support',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
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
    );
  }
}
