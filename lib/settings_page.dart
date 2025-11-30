import 'package:flutter/material.dart';
import 'package:flutter_web_app/gradient_background.dart';
import 'package:flutter_web_app/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ValueListenableBuilder<ThemeMode>(
          valueListenable: themeController,
          builder: (context, themeMode, _) {
            return ListView(
              children: [
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeController.toggleTheme();
                  },
                  secondary: Icon(
                    themeMode == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
