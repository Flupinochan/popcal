import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassSnackbarContent extends StatelessWidget {
  final String message;

  const GlassSnackbarContent({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 48,
      borderRadius: 12,
      blur: 20,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.1)],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.3)],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          // Centerを追加
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
