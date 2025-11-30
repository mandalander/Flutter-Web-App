import 'package:flutter/material.dart';
import 'package:flutter_web_app/theme_controller.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (context, themeMode, _) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: themeMode == ThemeMode.dark
                  ? const [
                      Color(0xFF0f0c29), // Very dark blue-purple
                      Color(0xFF1a1443), // Deep purple
                      Color(0xFF24243e), // Dark slate
                    ]
                  : const [
                      Color(0xFFf5f7fa), // Very light gray-blue
                      Color(0xFFe8f0fe), // Light blue tint
                      Color(0xFFffffff), // Pure white
                    ],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
