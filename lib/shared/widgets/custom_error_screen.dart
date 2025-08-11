import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_dialog.dart';

class CustomErrorScreen extends StatelessWidget {
  final String? title;
  final String? message;

  const CustomErrorScreen({super.key, this.title, this.message});

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: title ?? 'Error!'),
      drawer: const DrawerScreen(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          child: Center(
            child: GlassDialog(
              icon: Icons.priority_high,
              message: message ?? '予期しないエラーが発生しました',
              iconColor: glassTheme.errorBorderColor,
              backgroundGradient: glassTheme.errorGradient,
              borderColor: glassTheme.errorBorderColor,
            ),
          ),
        ),
      ),
    );
  }
}
