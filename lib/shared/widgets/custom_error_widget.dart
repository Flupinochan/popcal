import 'package:flutter/material.dart';
import 'package:popcal/core/themes/glass_theme.dart';
import 'package:popcal/features/drawer/presentation/screens/drawer_screen.dart';
import 'package:popcal/shared/widgets/glass_app_bar.dart';
import 'package:popcal/shared/widgets/glass_dialog.dart';

Widget customErrorWidget(BuildContext context, String message) {
  final glassTheme =
      Theme.of(context).extension<GlassTheme>() ?? GlassTheme.defaultTheme;

  return Scaffold(
    backgroundColor: glassTheme.backgroundColor,
    extendBodyBehindAppBar: true,
    appBar: GlassAppBar(title: 'Error!'),
    drawer: const DrawerScreen(),
    body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(gradient: glassTheme.primaryGradient),
      child: SafeArea(
        child: Center(
          child: GlassDialog(
            icon: Icons.priority_high,
            message: message,
            iconColor: glassTheme.errorBorderColor,
            backgroundGradient: glassTheme.errorGradient,
            borderColor: glassTheme.errorBorderColor,
          ),
        ),
      ),
    ),
  );
}

Widget customErrorSimpleWidget(BuildContext context, String message) {
  return Center(child: Text(message));
}
