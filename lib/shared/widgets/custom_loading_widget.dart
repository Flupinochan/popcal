import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';

class CustomLoadingScreen extends StatelessWidget {
  const CustomLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final glassTheme =
        Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

    return Scaffold(
      backgroundColor: glassTheme.backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(title: 'Loading...'),
      drawer: const DrawerScreen(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
        child: SafeArea(
          child: Center(
            child: CircularProgressIndicator(color: glassTheme.surfaceColor),
          ),
        ),
      ),
    );
  }
}

Widget customLoadingSimpleWidget(BuildContext context) {
  final glassTheme =
      Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

  return Center(
    child: CircularProgressIndicator(color: glassTheme.surfaceColor),
  );
}
