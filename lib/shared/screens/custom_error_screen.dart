import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/router/routes.dart';
import 'package:popcal/shared/widgets/dialog_content.dart';
import 'package:popcal/shared/widgets/glass_app_bar/glass_app_bar.dart';

class CustomErrorScreen extends StatelessWidget {
  const CustomErrorScreen({super.key, this.title, this.message});

  final String? title;
  final String? message;

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
            child: DialogContent(
              icon: Icons.priority_high,
              message: message ?? '予期しないエラーが発生しました',
              iconColor: glassTheme.errorBorderColor,
              borderColor: glassTheme.errorBorderColor,
              backgroundGradient: glassTheme.errorGradient,
              onPressed: () => const HomeRoute().go(context),
            ),
          ),
        ),
      ),
    );
  }
}
