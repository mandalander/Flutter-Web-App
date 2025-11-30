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
                      Color(0xFF667eea),
                      Color(0xFF764ba2),
                      Color(0xFFf093fb),
                    ]
                  : const [
                      Color(0xFF89f7fe),
                      Color(0xFF66a6ff),
                    ],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
