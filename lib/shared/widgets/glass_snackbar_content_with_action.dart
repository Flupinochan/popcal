import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassSnackbarContentWithAction extends StatelessWidget {
  final String message;
  final VoidCallback onAction;
  final String actionLabel;

  const GlassSnackbarContentWithAction({
    super.key,
    required this.message,
    required this.onAction,
    this.actionLabel = '元に戻す',
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 48,
      borderRadius: 12,
      blur: 20,
      border: 1,
      alignment: Alignment.center,
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
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(width: 12),
            GlassmorphicContainer(
              width: 80,
              height: 32,
              borderRadius: 16,
              blur: 10,
              alignment: Alignment.center,
              border: 1,
              linearGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              borderGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.3),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onAction,
                  borderRadius: BorderRadius.circular(16),
                  child: Center(
                    child: Text(
                      actionLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
